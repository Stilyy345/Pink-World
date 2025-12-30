extends CanvasLayer

@onready var rect: ColorRect = $ColorRect

func fade_out(duration := 0.5) -> void:
	if rect == null:
		push_error("FadeLayer: ColorRect not found")
		return

	var tween := create_tween()
	tween.tween_property(rect, "modulate:a", 1.0, duration)

func fade_in(duration := 0.5) -> void:
	if rect == null:
		push_error("FadeLayer: ColorRect not found")
		return

	var tween := create_tween()
	tween.tween_property(rect, "modulate:a", 0.0, duration)
