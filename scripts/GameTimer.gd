extends Node

var deaths := 0
var time := 0.0
var running := false
var star_fragments := 0
var collected_fragments: Dictionary = {} # IDS

func start():
	time = 0.0
	running = true

func stop():
	running = false

func reset():
	time = 0.0
	deaths = 0
	star_fragments = 0
	collected_fragments.clear()
	running = false

func add_death():
	deaths += 1
	
func collect_fragment(id: String):
	collected_fragments[id] = true
	star_fragments += 1

func has_fragment(id: String) -> bool:
	return collected_fragments.has(id)
	
func _process(delta):
	if running:
		time += delta
