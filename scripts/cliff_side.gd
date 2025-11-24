extends Node2D

func _ready():
	await get_tree().process_frame
	$player.global_position = Vector2(global.player_start_posx, global.player_start_posy)
