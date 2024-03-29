class_name BallParticles
extends Node2D

const SUPER_THRESHOLD = 2

@onready var combo_stars: GPUParticles2D = $ComboStars
@onready var super_stars: GPUParticles2D = $SuperStars

func set_combo(level: int) -> void:
	var super_level := level > SUPER_THRESHOLD
	super_stars.visible = super_level
	combo_stars.visible = level >= 2
	combo_stars.amount = level if super_level else level * 2
	super_stars.amount = (level - SUPER_THRESHOLD + 1) * 2
