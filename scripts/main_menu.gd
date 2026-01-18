extends Control

func _on_button_pressed() -> void:
	GameTimer.reset()
	GameTimer.start()
	get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/options_menu.tscn")

func _on_button_3_pressed() -> void:
	get_tree().quit()
