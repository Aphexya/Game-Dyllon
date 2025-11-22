extends Node2D

func _process(delta):
	change_scene()

func change_scene():
	if global.transition_scene:
		if global.next_scene_path != "":
			get_tree().change_scene_to_file(global.next_scene_path)
			global.finish_changescenes()
