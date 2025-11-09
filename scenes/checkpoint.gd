extends Sprite2D

func _ready() -> void:
	_update_sprite()
	
	if global.checkpoint_pos != Vector2(-999, -999):
		global_position = global.checkpoint_pos

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		global.checkpoint_pos= $Marker2D.global_position
		if global.previous_checkpoint_node:
			global.previous_checkpoint_node._update_sprite()
		global.previous_checkpoint_node = self
		_update_sprite()


func _update_sprite() -> void:
	if $Marker2D.global_position == global.checkpoint_pos:
		frame = 1
		modulate = Color(0, 1, 0) # hijau = aktif
	else:
		frame = 0
		modulate = Color(1, 1, 1)
