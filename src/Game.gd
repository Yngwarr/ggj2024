extends Node2D

## The game node, the beginning of all, the almighty entry point, the place,
## where your dreams come true! Adjust to your likings and may the code be with
## you.

const VICTORY: int = 15
const FAILURE: int = -10

## Must have [code]process_mode == PROCESS_MODE_WHEN_PAUSED[/code].
@export var crowd_progress: CrowdProgress

@export_group("Game over")
@export var victory_confetti: Array[Confetti]
@export var victory_screen: CanvasLayer
@export var failure_screen: CanvasLayer
@export var victory_sound: AudioStream
@export var failure_sound: AudioStream

@onready var clown: Clown = $Clown
@onready var ball_dispenser: BallDispenser = $BallDispenser
@onready var sound_player: AudioStreamPlayer = $GameOverSound
@onready var music_player: AudioStreamPlayer = $Music

var happiness: int = 0

func _ready() -> void:
	Global.game_over = false
	ball_dispenser.ball_dropped.connect(clown.become_sad)
	ball_dispenser.ball_spawned.connect(clown.concentrate)
	ball_dispenser.level_up.connect(clown.become_happy)
	ball_dispenser.level_up.connect(increase_happiness)
	ball_dispenser.ball_dropped.connect(decrease_happiness)

	crowd_progress.set_value(happiness)
	crowd_progress.set_bounds(FAILURE, VICTORY)

func increase_happiness(_level: int) -> void:
	happiness += 5
	crowd_progress.set_value(happiness)
	if happiness >= VICTORY:
		victory()

func decrease_happiness() -> void:
	happiness -= 1
	crowd_progress.set_value(happiness)
	if happiness <= FAILURE:
		failure()

func victory() -> void:
	Global.game_over = true
	for c in victory_confetti:
		c.emit()
	clown.victory()
	music_player.stop()
	sound_player.stream = victory_sound
	sound_player.play()

	await get_tree().create_timer(4).timeout

	if not get_tree().paused:
		get_tree().paused = true
	victory_screen.visible = true

func failure() -> void:
	Global.game_over = true
	clown.failure()
	sound_player.stream = failure_sound
	sound_player.play()

	await get_tree().create_timer(4).timeout

	if not get_tree().paused:
		get_tree().paused = true
	failure_screen.visible = true
