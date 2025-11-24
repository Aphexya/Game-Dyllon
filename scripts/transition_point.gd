extends Area2D

@export var target_scene: String
@export var spawn_pos: Vector2

func _on_body_entered(body):
	if body.is_in_group("player"):
		global.next_spawn_pos = spawn_pos
		global.use_transition_spawn = true
		get_tree().change_scene_to_file(target_scene)
