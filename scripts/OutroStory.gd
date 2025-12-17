extends CanvasLayer

func _ready():
	if not $AudioStreamPlayer.playing:
		$AudioStreamPlayer.play()

func _on_button_next_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/VictoryScreen.tscn")
