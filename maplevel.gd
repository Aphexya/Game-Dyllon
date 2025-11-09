extends Node2D

func _load_level() -> void:
	global.checkpoint_pos = Vector2 (-999, -999)
	global.previous_checkpoint_node = null
	get_tree().change_scene_to_file("res://game.tscn")
