extends Sprite2D

@export var happy: Texture
@export var smile: Texture
@export var neutral: Texture
@export var angry: Texture

enum CrowdMood { NEUTRAL, SMILE, HAPPY, ANGRY }

func _ready():
	pass

func set_mood():
	pass

#if progress >=6 then textureName="progress_happy"
#if progress >=3 and progress <=5 then textureName="progress_smile"
#if progress =1 or progress=2 then textureName="progress_neutral"
#if progress=0 then textureName="progress_angry"

