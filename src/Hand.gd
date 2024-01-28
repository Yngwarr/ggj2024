class_name Hand
extends CharacterBody2D

const INPUT_MULT := 20.0

@export var right := false
@export var sounds: Array[AudioStream]

var input: Vector2
var bounce_rotation: float = 40

@onready var sound_player: AudioStreamPlayer = $SoundPlayer
@onready var hint = $Hint

var input_left := &"game_ll"
var input_right := &"game_lr"
var input_up := &"game_lu"
var input_down := &"game_ld"
var input_bounce := &"game_lbounce"

@onready var ball_detector: Area2D = $BallDetector

func setup_right() -> void:
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

func _ready() -> void:
	if right:
		setup_right()

	ball_detector.body_exited.connect(ball_left)

	hint.show_hint(right)

func _physics_process(_delta: float) -> void:
	input = get_mouse_input() if right else get_keyboard_input()

	var collision := move_and_collide(input * INPUT_MULT)
	if collision:
		# velocity = velocity.slide(collision.get_normal())
		var norm := collision.get_normal()
		var other := collision.get_collider()
		if other.is_in_group(&"ball"):
			other.apply_force(norm * -30000)


	if Input.is_action_just_pressed(input_bounce):
		hint.hide_hint()
		var tween := create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
		tween.tween_property(self, "rotation_degrees", bounce_rotation, .3) \
			.set_trans(Tween.TRANS_CUBIC) \
			.set_ease(Tween.EASE_OUT)
		tween.chain() \
			.tween_property(self, "rotation_degrees", 0, .3) \
			.set_trans(Tween.TRANS_CUBIC) \
			.set_ease(Tween.EASE_OUT)

func ball_left(ball: Node2D) -> void:
	if not ball.is_in_group(&"ball"):
		return

	ball.touched_by(self)

func get_keyboard_input() -> Vector2:
	return Vector2(
				Input.get_axis(input_left, input_right),
				Input.get_axis(input_up, input_down)
			).normalized()

func get_mouse_input() -> Vector2:
	var direction = get_global_mouse_position() - global_position

	if direction.length() < INPUT_MULT:
		return Vector2.ZERO

	return direction.normalized()

func play_boink(combo: int) -> void:
	sound_player.stream = sounds[clamp(combo, 0, len(sounds) - 1)]
	sound_player.play()
