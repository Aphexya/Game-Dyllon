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

# Jika player menyentuh titik masuk ke cliff_side, aktifkan transisi
func _on_cliffside_transition_point_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		global.transition_scene = true

func _on_cliffside_transition_point_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		global.transition_scene = false


# Pindah scene ke cliff_side
func change_scene():
	if global.transition_scene == true:
		if global.current_scene == "world":
			get_tree().change_scene_to_file("res://scenes/cliff_side.tscn")
			global.game_first_loading = false
			global.finish_changescenes()


func _on_inventory_gui_closed() -> void:
	global.player_can_move = true


func _on_inventory_gui_opened() -> void:
	global.player_can_move = false
