extends Control

@onready var text_label = $Panel/RichTextLabel
@onready var button_ok = $Panel/ButtonOK

func _ready():
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS

func show_message(message: String):
	text_label.text = message
	visible = true
	get_tree().paused = true


func _on_ButtonOk_pressed() -> void:
	visible = false
	get_tree().paused = false
