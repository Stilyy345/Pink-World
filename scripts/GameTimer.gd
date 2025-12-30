extends Node

var deaths := 0
var time := 0.0
var running := false

func start():
	time = 0.0
	running = true

func stop():
	running = false

func reset():
	time = 0.0
	deaths = 0
	running = false

func add_death():
	deaths += 1

func _process(delta):
	if running:
		time += delta
