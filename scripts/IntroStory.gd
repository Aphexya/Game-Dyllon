extends CanvasLayer

func _on_button_next_pressed() -> void:
	var howto = load("res://scenes/HowToPlay.tscn").instantiate()
	get_parent().add_child(howto)
	queue_free()
