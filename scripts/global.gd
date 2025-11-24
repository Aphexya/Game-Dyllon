extends Node

# Script global untuk menyimpan variabel dan status antar-scene.
var player_current_attack = false
var current_scene: String = "world"
var transition_scene = false # status apakah sedang transisi scene

var next_scene_path: String = ""
var next_spawn_pos: Vector2 = Vector2.ZERO
var use_transition_spawn := false


# Posisi transisi player antar-scene
var player_exit_cliffside_posx = 304.0
var player_exit_cliffside_posy = 36.0
var player_start_posx = 64.0
var player_start_posy = 153.0

var game_first_loading = true

var player_can_move: bool = true

#Checkpoint
var checkpoint_scene_pos := {
	"world": Vector2(-999, -999),
	"dunia2": Vector2(-999, -999),
	"dunia3": Vector2(-999, -999),
	"dunia4": Vector2(-999, -999),
	"dunia5": Vector2(-999, -999),
	"cliff_side": Vector2(-999, -999)
}

var previous_checkpoint_node : Sprite2D = null
