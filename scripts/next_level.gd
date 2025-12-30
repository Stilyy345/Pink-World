extends Area2D
const FILE_BEGIN = "res://scenes/levels/level_"

func _on_body_entered(body: Node2D) -> void:
	print("ENTERED:", body)
	if body.is_in_group("Player"):
		body.input_locked = true
		call_deferred("_go_to_next_level")

func _go_to_next_level() -> void:
	
	# 1. Show banner
	LevelComplete.show_message()
	
	# 2. Short pause so player can read it
	await get_tree().create_timer(1.0).timeout
	
	# 3. Fade out
	FadeLayer.fade_out(0.5)
	await get_tree().create_timer(0.5).timeout
	
	# 4. Compute next level
	var current_scene_path := get_tree().current_scene.scene_file_path
	var file_name := current_scene_path.get_file()        # level_1.tscn
	var base_name := file_name.get_basename()              # level_1
	var level_number := int(base_name.replace("level_", ""))

	var next_level_number := level_number + 1
	var next_level_path := "res://scenes/levels/level_" + str(next_level_number) + ".tscn"

	# 5. Change Scene
	get_tree().change_scene_to_file(next_level_path) 
	
	# 6. Hide banner + fade in (autoloads survive)
	LevelComplete.hide_message()
	FadeLayer.fade_in(0.5)	
