extends Sprite2D

@export var clown_bg: Texture2D
@export var regular_bg: Texture2D

func _ready() -> void:
    set_bg(Global.coulrophobia_mode)

func set_bg(regular: bool):
    texture = regular_bg if regular else clown_bg

