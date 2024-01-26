class_name Hand
extends CharacterBody2D

const INPUT_MULT := 10.0

@export var right := false

var input: Vector2
var bounce_rotation: float = 50

var input_left := &"game_ll"
var input_right := &"game_lr"
var input_up := &"game_lu"
var input_down := &"game_ld"
var input_bounce := &"game_lbounce"

func _ready() -> void:
	if right:
		input_left = &"game_rl"
		input_right = &"game_rr"
		input_up = &"game_ru"
		input_down = &"game_rd"
		input_bounce = &"game_rbounce"

		$View.scale.x *= -1
		$Collider.scale.x *= -1
		$View.position.x *= -1
		$Collider.position.x *= -1

		bounce_rotation *= -1

func _process(_delta: float) -> void:
	input = get_mouse_input() if right else get_keyboard_input()

func _physics_process(_delta: float) -> void:
	var collision := move_and_collide(input * INPUT_MULT)
	if collision:
		velocity = velocity.slide(collision.get_normal())

	if Input.is_action_just_pressed(input_bounce):
		var tween := create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
		tween.tween_property(self, "rotation_degrees", bounce_rotation, .3) \
			.set_trans(Tween.TRANS_CUBIC) \
			.set_ease(Tween.EASE_OUT)
		tween.chain() \
			.tween_property(self, "rotation_degrees", 0, .3) \
			.set_trans(Tween.TRANS_CUBIC) \
			.set_ease(Tween.EASE_OUT)

func get_keyboard_input() -> Vector2:
	return Vector2(
				Input.get_axis(input_left, input_right),
				Input.get_axis(input_up, input_down)
			).normalized()

func get_mouse_input() -> Vector2:
	var direction = get_global_mouse_position() - global_position

	if direction.length() < 5 * INPUT_MULT:
		return Vector2.ZERO

	return direction.normalized()
