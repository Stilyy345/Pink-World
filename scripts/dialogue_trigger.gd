extends Area2D

@export var dialogue_lines: Array[String] = []
@export var trigger_once: bool = true

var _triggered: bool = false

func _on_body_entered(body: Node2D) -> void:
	if body.name != "Player":
		return
	
	if trigger_once and _triggered:
		return

	var ui := get_tree().get_first_node_in_group("DialogueUI")
	#print("Found DialogueUI node:", ui)

	if ui:
		#print("Calling start_dialogue...")
		ui.start_dialogue(dialogue_lines)
	else:
		print("ERROR: No node in group 'DialogueUI'")

	if trigger_once:
		_triggered = true
		set_deferred("monitoring", false)
		set_deferred("monitorable", false)
