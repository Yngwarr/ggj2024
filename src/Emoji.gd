class_name Emoji
extends Sprite2D

@export var happy: Texture
@export var smile: Texture
@export var neutral: Texture
@export var angry: Texture

enum Mood { NEUTRAL, SMILE, HAPPY, ANGRY }

func set_mood(mood: Mood):
	match mood:
		Mood.HAPPY: texture = happy
		Mood.SMILE: texture = smile
		Mood.NEUTRAL: texture = neutral
		Mood.ANGRY: texture = angry
