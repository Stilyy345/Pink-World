extends CharacterBody2D

@export var speed: float = 120.0
@export var jump_velocity: float = -250.0
@onready var anim: AnimatedSprite2D = $Sprite2D

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	print(anim.sprite_frames.get_animation_names())
	anim.play("default")
	
func _physics_process(delta: float) -> void:
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
