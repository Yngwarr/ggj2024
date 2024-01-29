extends Node

@export var pause_screen: CanvasLayer

func _process(_delta) -> void:
	if Input.is_action_just_pressed("game_pause"):
		if not get_tree().paused:
			get_tree().paused = true
			pause_screen.pause()
