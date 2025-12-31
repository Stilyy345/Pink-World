extends Control


@onready var time_label: Label = $VBoxContainer/TimeLabel
@onready var stars_label: Label = $VBoxContainer/StarsLabel
@onready var deaths_label: Label = $VBoxContainer/DeathsLabel

# CHANGE THIS to the real total later
const TOTAL_STARS := 16

func _ready():
	# Fill statistics
	time_label.text = "You completed the game in " + _format_time(GameTimer.time) + "!"
	deaths_label.text = "You died " + str(GameTimer.deaths) + " times!"
	stars_label.text = "You collected %d / %d" % [
		GameTimer.star_fragments,
		TOTAL_STARS
	] + " stars!"


func _format_time(t: float) -> String:
	var minutes := int(t) / 60
	var seconds := int(t) % 60
	var milliseconds := int((t - int(t)) * 100)

	return "%02d:%02d.%02d" % [minutes, seconds, milliseconds]

func _on_main_menu_button_pressed():
	GameTimer.reset()
	get_tree().change_scene_to_file("res://ui/main_menu.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
