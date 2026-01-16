extends Control

func _on_start_pressed() -> void:
	GameTimer.reset()    # new run = clean state
	GameTimer.start()    # start timer ONCE
	get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")

func _on_setting_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/options_menu.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()
