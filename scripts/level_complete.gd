extends CanvasLayer

@onready var label: Label = $Label

var time := 0.0
var move_distance := 12.0     # how much to move up and down
var move_speed := 1.2         
var color_speed := 2.0        # speed of changing colors
var base_y := 0.0

func _ready() -> void:
	base_y = label.position.y
	label.modulate.a = 0.0      

func show_message():
	label.modulate.a = 1.0
	set_process(true)

func hide_message():
	label.modulate.a = 0.0
	set_process(false)

func _process(delta: float) -> void:
	time += delta

	#  movement without pause
	label.position.y = base_y + sin(time * move_speed) * move_distance

	# non stop color changing
	var r := sin(time * color_speed) * 0.5 + 0.5
	var g := sin(time * color_speed + 2.0) * 0.5 + 0.5
	var b := sin(time * color_speed + 4.0) * 0.5 + 0.5
	label.modulate = Color(r, g, b, label.modulate.a)
