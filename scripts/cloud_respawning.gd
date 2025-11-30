extends StaticBody2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var vanishing_timer:Timer = $VanishingTimer
@onready var respawn_timer: Timer = $RespawnTimer

var start_position: Vector2

func _ready() -> void:
	start_position = global_position
	print("READY: start_position =", start_position)
	
func _on_trigger_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and vanishing_timer.is_stopped() and respawn_timer.is_stopped():
		print("TRIGGER: player entered, starting vanish timer")
		vanishing_timer.start()

func _on_vanishing_timer_timeout() -> void:
	print("VANISH TIMER FIRED")
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0, 0.4)
	collision_shape_2d.disabled = true
	respawn_timer.start()

func _on_respawn_timer_timeout() -> void:
	print("RESPAWN TIMER FIRED")
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1, 2.5)
	global_position = start_position
	collision_shape_2d.disabled = false
