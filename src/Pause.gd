extends Node

@export var pause_screen: CanvasLayer

func _process(_delta) -> void:
	if Input.is_action_just_pressed("game_pause"):
		if get_tree().paused:
			pause_screen.unpause()
		else:
			get_tree().paused = true
			pause_screen.pause()
