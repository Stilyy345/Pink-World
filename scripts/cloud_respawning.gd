extends StaticBody2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var timer:Timer = $VanishingTimer
@onready var respawn_timer: Timer = $RespawnTimer
var original_pos: Vector2

func _ready() -> void:      # NEW
	# remember where the collider started
	original_pos = collision_shape_2d.position
	# make sure respawn timer calls our function
		
func _on_trigger_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		timer.start()

func _on_vanishing_timer_timeout() -> void:
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0, 0.4)
	collision_shape_2d.position = Vector2(-10000, 20000)
	respawn_timer.start()

func _on_respawn_timer_timeout() -> void:
	collision_shape_2d.position = original_pos
	# Reset alpha
	self.modulate.a = 1.0

	
