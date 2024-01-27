class_name PhobiaBox
extends CheckBox

func _ready() -> void:
    toggled.connect(toggle_phobia)

func toggle_phobia(on: bool) -> void:
    Global.coulrophobia_mode = on

func load() -> void:
    set_pressed_no_signal(Global.coulrophobia_mode)
