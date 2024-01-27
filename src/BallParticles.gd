class_name BallParticles
extends Node2D

const SUPER_THRESHOLD = 4

@onready var combo_stars: GPUParticles2D = $ComboStars
@onready var super_stars: GPUParticles2D = $SuperStars

func set_combo(level: int) -> void:
	var super_level := level > SUPER_THRESHOLD
	super_stars.visible = super_level
	combo_stars.amount = level * 2 if super_level else level
	super_stars.amount = (level - SUPER_THRESHOLD) * 2
