extends Node

var time := 0.0
var running := false

func start():
	time = 0.0
	running = true

func stop():
	running = false

func reset():
	time = 0.0
	running = false

func _process(delta):
	if running:
		time += delta
