extends Node2D

@onready var player = $player

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

	# ✅ HANYA pindahkan player jika datang dari scene lain
	if global.next_spawn_pos != Vector2.ZERO:
		player.global_position = global.next_spawn_pos
		global.next_spawn_pos = Vector2.ZERO
		
	var cp = global.checkpoint_scene_pos[global.current_scene]

	if cp != Vector2(-999, -999):
		player.global_position = cp


func _on_inventory_gui_closed() -> void:
	global.player_can_move = true


func _on_inventory_gui_opened() -> void:
	global.player_can_move = false

func respawn_at_checkpoint():
	var cp = global.checkpoint_scene_pos[global.current_scene]

	if cp != Vector2(-999, -999):
		player.global_position = cp

	for enemy in get_tree().get_nodes_in_group("enemy"):
		enemy.reset_enemy()
