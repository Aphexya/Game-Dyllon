extends CanvasLayer

func _on_button_ok_pressed() -> void:
	global.current_scene = "world"
	GameTimer.start()
	get_tree().change_scene_to_file("res://scenes/dunia.tscn")
