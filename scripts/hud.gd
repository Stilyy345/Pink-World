extends CanvasLayer

@onready var stars_label: Label = $StarsLabel

func _process(_delta):
	stars_label.text = "Stars Collected: " + str(GameTimer.star_fragments)
