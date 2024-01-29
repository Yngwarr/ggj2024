class_name Clown
extends Node2D

enum ClownSkin { CLOWN, REGULAR }

@export_group("Clown skin")
@export var clown_body: Texture2D
@export var clown_hair: Texture2D
@export var clown_face: Texture2D

@export_group("Regular skin")
@export var regular_body: Texture2D
@export var regular_hair: Texture2D
@export var regular_face: Texture2D

@onready var body: Sprite2D = $Body
@onready var hair: Sprite2D = $Hair
@onready var face: Sprite2D = $Face
@onready var anim: AnimationPlayer = $AnimationPlayer

var default_animation := &"smile_loop"

func _ready() -> void:
	anim.play(&"smile_loop")
	set_skin(ClownSkin.REGULAR if Global.coulrophobia_mode else ClownSkin.CLOWN)

func become_sad() -> void:
	if Global.game_over:
		return
	anim.play(&"sad_loop")
	anim.queue(default_animation)

func become_happy(_current_level: int) -> void:
	anim.play(&"happy_loop")
	anim.queue(default_animation)

func victory() -> void:
	anim.play(&"victory")

func failure() -> void:
	anim.play(&"scared_loop")

func concentrate(balls_in_air) -> void:
	if balls_in_air < 3:
		return

	default_animation = &"neutral_loop"

func set_skin(skin: ClownSkin) -> void:
	match skin:
		ClownSkin.CLOWN:
			body.texture = clown_body
			hair.texture = clown_hair
			face.texture = clown_face
		ClownSkin.REGULAR:
			body.texture = regular_body
			hair.texture = regular_hair
			face.texture = regular_face

