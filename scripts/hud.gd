extends CanvasLayer

@onready var value_label: Label = $PanelContainer/MarginContainer/StarsValue

var _last_value := -1
var _tween: Tween

const COLOR_NORMAL := Color(0.95, 0.81, 0.95) # pastel pink
const COLOR_FLASH  := Color(1.0, 1.0, 1.0)   # white

func _ready():
	_update_value(GameTimer.star_fragments, false)

func _process(_delta):
	var current := GameTimer.star_fragments
	if current == _last_value:
		return

	_update_value(current, true)

func _update_value(value: int, animate: bool):
	_last_value = value
	value_label.text = str(value)

	if not animate:
		value_label.modulate = COLOR_NORMAL
		value_label.scale = Vector2.ONE
		return

	_play_animation()

func _play_animation():
	if _tween and _tween.is_running():
		_tween.kill()

	value_label.scale = Vector2.ONE
	value_label.modulate = COLOR_NORMAL

	_tween = create_tween()

	# Scale pop
	_tween.tween_property(value_label, "scale", Vector2(1.2, 1.2), 0.10)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	_tween.tween_property(value_label, "scale", Vector2.ONE, 0.14)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)

	# Color flash (parallel)
	_tween.parallel().tween_property(value_label, "modulate", COLOR_FLASH, 0.10)
	_tween.tween_property(value_label, "modulate", COLOR_NORMAL, 0.18)
