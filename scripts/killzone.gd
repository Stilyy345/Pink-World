extends Area2D

@onready var timer: Timer = $Timer
var triggered := false

func _on_body_entered(body: Node2D) -> void:
	if triggered:
		return
	if body.name != "Player":
		return
		
	triggered = true
	GameTimer.add_death()
	#print("You died!")
	timer.start()

func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
