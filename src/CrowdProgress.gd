class_name CrowdProgress
extends Control

@export var happy_color: Color
@export var smile_color: Color
@export var neutral_color: Color
@export var angry_color: Color

@onready var bar: TextureProgressBar = $TextureProgressBar
@onready var emoji: Emoji = $Emoji

func set_value(value) -> void:
	if Global.game_over:
		return

	var mood: Emoji.Mood = Emoji.Mood.ANGRY
	var color := angry_color

	if value >= 7:
		mood = Emoji.Mood.HAPPY
		color = happy_color
	elif value >= 5:
		mood = Emoji.Mood.SMILE
		color = smile_color
	elif value >= -5:
		mood = Emoji.Mood.NEUTRAL
		color = neutral_color

	var tween := create_tween()
	tween.tween_property(bar, "value", value, .3) \
		.set_trans(Tween.TRANS_QUAD) \
		.set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(bar, "tint_progress", color, .3) \
		.set_trans(Tween.TRANS_QUAD) \
		.set_ease(Tween.EASE_OUT)

	emoji.set_mood(mood)

func set_bounds(min_value: int, max_value: int):
	bar.max_value = max_value
	bar.min_value = min_value
