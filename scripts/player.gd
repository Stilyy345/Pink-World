extends CharacterBody2D

@export var speed: float = 120.0
@export var jump_velocity: float = -250.0
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

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

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	move_and_slide()
