class_name Confetti
extends Node2D

func emit() -> void:
    for c in get_children():
        c.emitting = true
