class_name Ball
extends RigidBody2D

signal combo_increased(level: int)
signal combo_reset

@onready var view: Node2D = $View
@onready var flare: Node2D = $Flare
@onready var particles: BallParticles = $Particles

enum Touch { NONE, LEFT, RIGHT }

var combo: int = 0
var last_touch: Touch = Touch.NONE
var first_touch: Touch = Touch.NONE

func _ready() -> void:
	particles.set_combo(combo)
	$AnimationPlayer.play(&"idle")

func _physics_process(_delta: float) -> void:
	flare.rotation = -rotation

func set_color(color: Color) -> void:
	view.modulate = color

func touched_by(hand: Hand) -> void:
	var touch: Touch = Touch.RIGHT if hand.right else Touch.LEFT
	if last_touch == Touch.NONE:
		first_touch = touch
		inc_combo()
	elif touch != last_touch:
		if first_touch == touch:
			inc_combo()
	else:
		reset_combo(touch)
	last_touch = touch

func inc_combo() -> void:
	combo += 1
	particles.set_combo(combo)
	combo_increased.emit(combo)

func reset_combo(touch: Touch) -> void:
	first_touch = touch
	combo = 1
	particles.set_combo(combo)
	combo_reset.emit()
