class_name Ball
extends RigidBody2D

@onready var view: Node2D = $View

func set_color(color: Color) -> void:
	view.modulate = color
