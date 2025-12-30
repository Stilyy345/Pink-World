extends CanvasLayer

@onready var label: Label = $Label

func show_message():
	label.modulate.a = 1.0

func hide_message():
	label.modulate.a = 0.0
