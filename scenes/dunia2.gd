extends Node2D

func _ready():
	await get_tree().process_frame  # aman, tunggu semua node spawn
	
	var player = get_node_or_null("Player")
	if player:
		player.global_position = global.next_spawn_pos
	else:
		print("⚠️ Player tidak ditemukan di scene ini!")
