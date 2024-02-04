extends CanvasLayer

## Your average pause menu you can use to rage quit the game, go outside and
## touch some grass.

@export var resume_button: Button
@export var options_menu: PopupPanel

func _ready() -> void:
	resume_button.pressed.connect(unpause)
	options_menu.visibility_changed.connect(options_toggled)

	resume_button.grab_focus()

func options_toggled() -> void:
	if options_menu.visible: return

func pause() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	show()
	resume_button.grab_focus()

func unpause() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	hide()
	get_tree().paused = false
