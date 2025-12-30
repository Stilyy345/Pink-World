@tool
extends Area2D

# -------- CONFIG --------
@export var fragment_id: String = ""
@export var fragment_index := 0:
	set(value):
		fragment_index = value
		if is_inside_tree():
			_update_region()

@export var fragment_size := Vector2(16, 16)

# -------- NODES --------
@onready var sprite: Sprite2D = $Sprite2D

# -------- STATE --------
var player_in_range := false

# -------- LIFECYCLE --------
func _ready():
	_update_region()

	# DO NOT touch GameTimer in the editor
	if Engine.is_editor_hint():
		return

	# Runtime only ↓↓↓
	if fragment_id != "" and GameTimer.has_fragment(fragment_id):
		queue_free()
		return

	if has_node("AnimationPlayer"):
		$AnimationPlayer.play("float")

func _process(_delta):
	if player_in_range and Input.is_action_just_pressed("interact"):
		_collect()

# -------- REGION / VISUAL --------
func _update_region():
	if sprite == null or sprite.texture == null:
		return

	sprite.region_enabled = true
	sprite.region_rect = Rect2(
		Vector2(0, fragment_index * fragment_size.y),
		fragment_size
	)

# -------- COLLISION --------
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_in_range = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_in_range = false

# -------- COLLECTION --------
func _collect():
	# Prevent double collection
	if fragment_id != "" and GameTimer.has_fragment(fragment_id):
		return

	# Persist collection if ID exists
	if fragment_id != "":
		GameTimer.collect_fragment(fragment_id)

	# Visual feedback
	if has_node("AnimationPlayer"):
		$AnimationPlayer.stop()

	var t := create_tween()
	t.tween_property(sprite, "scale", Vector2(1.4, 1.4), 0.15)
	t.parallel().tween_property(sprite, "modulate:a", 0.0, 0.15)

	await t.finished
	queue_free()
