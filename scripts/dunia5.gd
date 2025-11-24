extends Node2D

func _ready():
	await get_tree().process_frame

	var player = $player
	var cam = player.get_node("Camera2D")
	cam.make_current()

	var tilemap = $TileMap
	var rect = tilemap.get_used_rect()
	var cell = tilemap.tile_set.tile_size

	cam.limit_left   = rect.position.x * cell.x
	cam.limit_top    = rect.position.y * cell.y
	cam.limit_right  = cam.limit_left + rect.size.x * cell.x
	cam.limit_bottom = cam.limit_top + rect.size.y * cell.y

	if global.use_transition_spawn:
		if global.next_spawn_pos != Vector2.ZERO:
			player.global_position = global.next_spawn_pos
		else:
			var spawn_point = $SpawnPoint
			player.global_position = spawn_point.global_position

		global.use_transition_spawn = false

	print("Spawn dunia5:", player.global_position)
