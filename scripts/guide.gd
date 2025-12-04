extends Node2D

@export var dialogue_lines: Array[String] = []
var player_in_range: bool = false

func _ready() -> void:
	# Connect Area2D signals
	var area := $Area2D
	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited)

func _process(_delta: float) -> void:
	if player_in_range and Input.is_action_just_pressed("interact"):
		_start_dialogue()

func _on_body_entered(body: Node) -> void:
	if body.name == "Player":
		player_in_range = true

func _on_body_exited(body: Node) -> void:
	if body.name == "Player":
		player_in_range = false

func _start_dialogue() -> void:
	var ui := get_tree().get_first_node_in_group("DialogueUI")
	if ui:
		ui.start_dialogue(dialogue_lines)
