extends CanvasLayer

# =====================================================
# READY FUNCTION
# Dipanggil saat Game Over UI muncul.
# - Memastikan musik Game Over diputar.
# - Mem-pause seluruh gameplay tetapi UI tetap aktif.
# =====================================================
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	if not $AudioStreamPlayer.playing:
		$AudioStreamPlayer.play()
	get_tree().paused = true


# =====================================================
# TOMBOL "YES" → Respawn di Checkpoint
# - Unpause game
# - Memanggil fungsi respawn player
# - Menghidupkan player kembali
# - Menghapus UI Game Over
# - Memanggil respawn semua musuh melalui dunia.gd
# =====================================================
func _on_button_yes_pressed() -> void:
	# YES = Respawn di checkpoint
	get_tree().paused = false

	var player = get_tree().get_first_node_in_group("player")
	if player:
		player.respawn()
		player.player_alive = true
		global.player_can_move = true

	queue_free()
	get_tree().current_scene.respawn_at_checkpoint()


# =====================================================
# TOMBOL "NO" → Kembali ke Main Menu
# - Unpause game
# - Langsung ganti ke scene main menu
# =====================================================
func _on_button_no_pressed() -> void:
	# NO = Kembali ke menu
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
