extends CharacterBody2D

@export var speed: float = 120.0
@export var jump_velocity: float = -250.0
@onready var anim: AnimatedSprite2D = $Sprite2D

var drowning := false
var spawn_position: Vector2
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	spawn_position = global_position
	anim.play("default")
	
func _physics_process(delta: float) -> void:
	#DROWNING
	if drowning:
		move_and_slide()
		return
		
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Horizontal input
	var input_dir := 0.0
	if Input.is_action_pressed("move_left"):
		input_dir -= 1.0
	if Input.is_action_pressed("move_right"):
		input_dir += 1.0

	velocity.x = input_dir * speed

	# >>> Обръщане на героя по посока на движение <<<
	if input_dir != 0.0:
		$Sprite2D.flip_h = input_dir < 0.0

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
		anim.play("jump_start")
	
# --- ANIMATION LOGIC ---
	if not is_on_floor():
		# In the air
		if velocity.y > 0.0:
			# Falling / after apex → hold air pose
			if anim.animation != "jump_air":
				anim.play("jump_air")
		
	else:
		if input_dir != 0.0:
			# Walking only while there is input
			if anim.animation != "walk":
				anim.play("walk")
		else:
			# No input on ground → idle
			if anim.animation != "default":
				anim.play("default")
				
	move_and_slide()
	
func start_water_death():
	if drowning:
		return

	drowning = true 
	velocity = Vector2.ZERO

	# Optional: lock animation
	anim.stop()

	var tween := create_tween()

	# Sink down
	tween.tween_property(
		self,
		"position:y",
		position.y + 48,
		1.2
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)

	# Turn blue
	tween.parallel().tween_property(
		$Sprite2D,
		"modulate",
		Color(0.4, 0.6, 1.0),
		0.6
	)

	_restart_level_after_delay()
	
func _restart_level_after_delay() -> void:
	await get_tree().create_timer(1.25).timeout
	get_tree().reload_current_scene()
