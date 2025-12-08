extends Sprite2D

# =====================================================
# READY FUNCTION
# Saat checkpoint muncul di scene, sprite akan langsung
# diperbarui apakah ini checkpoint aktif atau bukan.
# =====================================================
func _ready():
	_update_sprite()

# =====================================================
# TRIGGER KETIKA PLAYER MENYENTUH CHECKPOINT
# Menyimpan posisi checkpoint ke global, mematikan
# checkpoint lama, dan menyalakan yang baru.
# =====================================================
func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):

		global.checkpoint_scene_pos[global.current_scene] = $Marker2D.global_position

		if global.previous_checkpoint_node:
			global.previous_checkpoint_node._update_sprite()

		global.previous_checkpoint_node = self
		_update_sprite()

# =====================================================
# UPDATE SPRITE CHECKPOINT
# Mengubah frame & warna: hijau = aktif, putih = non-aktif.
# =====================================================
func _update_sprite():
	if $Marker2D.global_position.distance_to(global.checkpoint_scene_pos[global.current_scene]) < 1:
		frame = 1
		modulate = Color(0, 1, 0) # aktif
	else:
		frame = 0
		modulate = Color(1, 1, 1) # non aktif
