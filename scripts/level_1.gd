extends Node2D

func _ready():
	FadeLayer.fade_in(0.5)
	print("FADE IN")
	GameTimer.start()
	print("TIMER STARTED IN LEVEL 1")
	
