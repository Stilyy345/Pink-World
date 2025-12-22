extends Control

@onready var guide := $Guide


func _ready() -> void:
	# скрий феята при старт
	guide.visible = false


func _on_button_pressed() -> void:
	# Back бутонът
	get_tree().change_scene_to_file("res://ui/main_menu.tscn")


func _on_label_2_mouse_entered() -> void:
	# мишката влиза върху текста за феята
	guide.visible = true
	print("mouse on fairy text")



func _on_label_2_mouse_exited() -> void:
	# мишката излиза от текста за феята
	guide.visible = false
