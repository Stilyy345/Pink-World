extends Control

func _ready() -> void:
	pass


func _on_button_pressed() -> void:
	pass

func _on_setting_pressed() -> void:
	# Open settings without unpausing
	get_tree().change_scene_to_file("res://scenes/options_menu.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()
