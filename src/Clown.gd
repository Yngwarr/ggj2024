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

func _ready() -> void:
	set_skin(ClownSkin.REGULAR if Global.coulrophobia_mode else ClownSkin.CLOWN)

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
