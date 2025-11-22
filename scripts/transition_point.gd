extends Area2D

@export var target_scene: String = ""
@export var spawn_pos: Vector2 = Vector2.ZERO

func _on_body_entered(body):
	print("Area2D disentuh:", body)
	if body.is_in_group("player"):
		print("Player terdeteksi! Target:", target_scene)
		global.transition_scene = true
		global.next_scene_path = target_scene
		global.next_spawn_pos = spawn_pos
