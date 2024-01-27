extends Node2D

signal config_loaded

## Main menu scene's main script.

## The node that will grab focus on ready. Usually, the top button on the
## screen.
@export var first_to_focus: Control
@export var phobia_toggles: Array[PhobiaBox]

@export var balls: GPUParticles2D
@export var header: AnimationPlayer

func _ready() -> void:
	balls.emitting = true
	header.play(&"Header")

	for toggle in phobia_toggles:
		config_loaded.connect(toggle.load)
	ConfigCtl.load_config()
	config_loaded.emit()
	first_to_focus.grab_focus()
