extends CanvasLayer

var lines: Array[String] = []
var current_index: int = 0
var is_active: bool = false

@onready var text_label: RichTextLabel = $Panel/RichTextLabel

func _ready() -> void:
	add_to_group("DialogueUI")
	hide()

func start_dialogue(new_lines: Array[String]) -> void:
	if new_lines.is_empty():
		return
	lines = new_lines
	current_index = 0
	is_active = true
	show()
	_show_current_line()

func _unhandled_input(event: InputEvent) -> void:
	if not is_active:
		return

	if event.is_action_pressed("ui_accept"):
		_next_line()

func _show_current_line() -> void:
	text_label.text = lines[current_index]

func _next_line() -> void:
	current_index += 1
	if current_index >= lines.size():
		_end_dialogue()
	else:
		_show_current_line()

func _end_dialogue() -> void:
	is_active = false
	hide()
