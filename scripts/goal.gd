extends Area2D

@export var next_level: PackedScene   # ще я изберем от Inspector

func _on_body_entered(body: Node2D) -> void:
	if body.name != "Player":
		return

	if next_level == null:
		push_error("next_level не е зададен в Inspector!")
		return

	print("Loading next level…")
	get_tree().change_scene_to_packed(next_level)


func _on_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
