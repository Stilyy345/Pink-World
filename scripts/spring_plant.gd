extends Area2D

@export var bounce_strength: float = -600.0

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if body.name == "Player":
		# Assuming Player is CharacterBody2D with 'velocity'
		body.velocity.y = bounce_strength
