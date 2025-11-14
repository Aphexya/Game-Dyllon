extends Node

# Script global untuk menyimpan variabel dan status antar-scene.
var player_current_attack = false
var current_scene = "main_menu" # scene aktif saat ini (world / cliff_side)
var transition_scene = false # status apakah sedang transisi scene

# Posisi transisi player antar-scene
var player_exit_cliffside_posx = 304.0
var player_exit_cliffside_posy = 36.0
var player_start_posx = 64.0
var player_start_posy = 153.0

var game_first_loading = true

var player_can_move: bool = true

# Fungsi untuk menandai bahwa transisi scene telah selesai
func finish_changescenes():

	transition_scene = false
	if current_scene == "world":
		current_scene = "cliff_side"
	else:
		current_scene = "world"
		

#Xheckpoint
var checkpoint_pos: Vector2 = Vector2(-999, -999)
var previous_checkpoint_node: Sprite2D = null
