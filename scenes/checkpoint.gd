extends Sprite2D

func _ready():
	_update_sprite()


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):

		global.checkpoint_scene_pos[global.current_scene] = $Marker2D.global_position

		if global.previous_checkpoint_node:
			global.previous_checkpoint_node._update_sprite()

		global.previous_checkpoint_node = self
		_update_sprite()


func _update_sprite():
	if $Marker2D.global_position.distance_to(global.checkpoint_scene_pos[global.current_scene]) < 1:
		frame = 1
		modulate = Color(0, 1, 0) # aktif
	else:
		frame = 0
		modulate = Color(1, 1, 1) # non aktif
