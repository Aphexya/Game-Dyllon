extends Control

@onready var dialog_box = $DialogBox
@onready var button_ok = $DialogBox/Panel/ButtonOK

func _ready():
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS

func show_dialog():
	visible = true

func _on_ButtonOk_pressed() -> void:
	visible = false
	get_tree().paused = false
