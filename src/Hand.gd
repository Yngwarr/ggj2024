class_name Hand
extends CharacterBody2D

const INPUT_MULT := 3.0

var input: Vector2

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	input = Vector2(
		Input.get_axis("game_ll", "game_lr"),
		Input.get_axis("game_lu", "game_ld")
	).normalized()

func _physics_process(_delta: float) -> void:
	var collision := move_and_collide(input * INPUT_MULT)
	if collision:
		velocity = velocity.slide(collision.get_normal())

	if Input.is_action_just_pressed("game_lbounce"):
		var tween := create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
		tween.tween_property(self, "rotation_degrees", 50, .3) \
			.set_trans(Tween.TRANS_CUBIC) \
			.set_ease(Tween.EASE_OUT)
		tween.chain() \
			.tween_property(self, "rotation_degrees", 0, .3) \
			.set_trans(Tween.TRANS_CUBIC) \
			.set_ease(Tween.EASE_OUT) \
