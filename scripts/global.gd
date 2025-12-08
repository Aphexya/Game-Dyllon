extends Node

# =====================================================
# SCRIPT GLOBAL (AUTLOAD)
# Menyimpan berbagai variabel penting yang digunakan
# antar-scene, seperti status serangan player,
# posisi spawn ketika transisi, checkpoint, dan
# kontrol gerakan player.
# =====================================================
var player_current_attack = false
var current_scene: String = "world"
var transition_scene = false # status apakah sedang transisi scene

var next_scene_path: String = ""
var next_spawn_pos: Vector2 = Vector2.ZERO
var use_transition_spawn := false


# =====================================================
# POSISI TRANSISI ANTAR-SCENE
# Digunakan saat player berpindah area menggunakan portal,
# pintu, atau titik transisi lainnya.
# =====================================================
var player_exit_cliffside_posx = 304.0
var player_exit_cliffside_posy = 36.0
var player_start_posx = 64.0
var player_start_posy = 153.0


# =====================================================
# STATUS GAME
# =====================================================
var game_first_loading = true

var player_can_move: bool = true

# =====================================================
# CHECKPOINT SYSTEM
# Menyimpan posisi checkpoint untuk tiap scene.
# Default -999 artinya belum ada checkpoint.
# =====================================================
var checkpoint_scene_pos := {
	"world": Vector2(-999, -999),
	"dunia2": Vector2(-999, -999),
	"dunia3": Vector2(-999, -999),
	"dunia4": Vector2(-999, -999),
	"dunia5": Vector2(-999, -999),
	"cliff_side": Vector2(-999, -999)
}

var previous_checkpoint_node : Sprite2D = null
