extends Node2D

# Script untuk scene utama (world), menangani transisi ke cliff_side.
func _ready():
	if global.game_first_loading == true:
		$Player.position.x = global.player_start_posx
		$Player.position.y = global.player_start_posy
	else: 
		$Player.position.x = global.player_exit_cliffside_posx 
		$Player.position.y = global.player_exit_cliffside_posy 
		

func _process(delta):
	change_scene()


# Pindah scene ke cliff_side
func change_scene():
	if global.transition_scene:
		print("Fungsi change_scene() aktif")
		print("Scene yg akan dibuka:", global.next_scene_path)

		if global.next_scene_path != "":
			get_tree().change_scene_to_file(global.next_scene_path)

			# SET ke FALSE agar tidak looping
			global.transition_scene = false

			global.game_first_loading = false
			global.player_start_posx = global.next_spawn_pos.x
			global.player_start_posy = global.next_spawn_pos.y
			
			global.finish_changescenes()




func _on_inventory_gui_closed() -> void:
	global.player_can_move = true


func _on_inventory_gui_opened() -> void:
	global.player_can_move = false
