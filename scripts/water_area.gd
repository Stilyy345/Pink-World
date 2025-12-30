extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.start_water_death()
		print("Water death started")
		
func _process(_delta):
	for body in get_overlapping_bodies():
		print("Overlapping:", body.name)
