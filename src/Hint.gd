extends Node2D

func _ready() -> void:
    $AnimationPlayer.play(&"idle")

func show_hint(right: bool) -> void:
    $HintLeft.visible = !right
    $HintRight.visible = right

func hide_hint() -> void:
    visible = false
