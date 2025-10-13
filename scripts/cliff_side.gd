extends Node2D

# Script untuk scene cliff_side, menangani perpindahan kembali ke dunia utama.
func _process(delta):
	change_scenes()

# Jika player menyentuh titik keluar, aktifkan transisi scene
func _on_cliffside_exitpoint_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		global.transition_scene = true

func _on_cliffside_exitpoint_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		global.transition_scene = false


# Pindah scene ke dunia utama (world)
func change_scenes():
	if global.transition_scene == true:
		if global.current_scene == "cliff_side":
			get_tree().change_scene_to_file("res://scenes/dunia.tscn")
			global.finish_changescenes()
