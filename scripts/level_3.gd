extends Control

@onready var deaths_label: Label = $VBoxContainer/DeathsLabel
@onready var time_label: Label = $VBoxContainer/TimeLabel
@onready var label: Label = $VBoxContainer/Label

func _ready() -> void:
	#Timer function
	print("END SCREEN TIMER VALUE:", GameTimer.time)
	GameTimer.stop()
	time_label.text = "Time: " + format_time(GameTimer.time)
	deaths_label.text = "Deaths: " + str(GameTimer.deaths)
	
	var base_y := label.position.y

	var colors := [
		Color(1.0, 0.6, 0.9),
		Color(0.6, 0.8, 1.0),
		Color(0.7, 1.0, 0.7),
		Color(1.0, 1.0, 0.5),
		Color(1.0, 0.7, 0.3)
	]

	# ===== ПЛАВНО ДВИЖЕНИЕ (FLOAT EFFECT) =====
	var move_distance := 6.0     # колко да се люлее
	var move_time := 1.2         # колко бавно (по-голямо = по-плавно)

	var move_tween := create_tween()
	move_tween.set_loops()
	move_tween.set_trans(Tween.TRANS_SINE)
	move_tween.set_ease(Tween.EASE_IN_OUT)

	move_tween.tween_property(
		label,
		"position:y",
		base_y - move_distance,
		move_time
	)
	move_tween.tween_property(
		label,
		"position:y",
		base_y + move_distance,
		move_time
	)

	# ===== ЦВЕТОВЕ (НОН-СТОП, ПЛАВНО) =====
	var color_time := 0.6

	var color_tween := create_tween()
	color_tween.set_loops()

	for c in colors:
		color_tween.tween_property(
			label,
			"modulate",
			c,
			color_time
		)

# ===== БУТОНИ =====

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/main_menu.tscn")

func _on_button_2_pressed() -> void:
	get_tree().quit()

func format_time(t: float) -> String:
	var minutes := int(t) / 60
	var seconds := int(t) % 60
	var milliseconds := int((t - int(t)) * 100)

	return "%02d:%02d.%02d" % [minutes, seconds, milliseconds]
