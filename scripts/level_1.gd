extends Node2D

func _ready():
	GameTimer.start()
	print("TIMER STARTED IN LEVEL 1")
	FadeLayer.fade_in(0.5)
	print("FADE IN")
