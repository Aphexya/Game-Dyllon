extends CharacterBody2D
# Script untuk AI musuh (slime): mengejar player, menerima damage, dan menampilkan health bar.
var speed = 40
var player_chase = false
var player = null
var health = 100
var player_inattack_zone = false
var can_take_damage = true
var is_dead = false  # Flag untuk mencegah logika berjalan setelah mati

# Update posisi dan animasi musuh setiap frame
func _physics_process(delta):
	# Hentikan semua logika jika sudah mati
	if is_dead:
		return
		
	deal_with_damage()
	update_health()
	
	if player_chase and player != null:
		var arah = (player.global_position - global_position).normalized()
		global_position += arah * speed * delta
		$AnimatedSprite2D.play("walk")
		
		# Balik arah sprite sesuai posisi player
		if arah.x < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.play("idle")

# Deteksi saat player masuk/keluar area deteksi musuh
func _on_detection_area_body_entered(body):
	if body.name == "Player":
		player = body
		player_chase = true
	
func _on_detection_area_body_exited(body):
	if body == player:
		player = null
		player_chase = false

func enemy():
	pass

# Deteksi area serangan player (hitbox)
func _on_enemy_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_inattack_zone = true
		
func _on_enemy_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_inattack_zone = false
	
# Mengatur logika damage yang diterima dari player
func deal_with_damage():
	if player_inattack_zone and global.player_current_attack == true:
		if can_take_damage:
			health -= 50
			$take_damage_cooldown.start()
			can_take_damage = false
			print("slime health = ", health)
			
			if health <= 0:
				die()  # Panggil fungsi death

# Fungsi untuk menjalankan animasi death dan menghapus enemy
func die():
	print("=== DIE FUNCTION CALLED ===")
	is_dead = true
	player_chase = false
	$healthbar.visible = false
	
	# Matikan collision agar tidak bisa diserang lagi
	$CollisionShape2D.disabled = true
	
	# Stop animasi yang sedang berjalan dan mainkan death
	$AnimatedSprite2D.stop()
	$AnimatedSprite2D.frame = 0
	
	print("Playing death animation...")
	print("Animation exists: ", $AnimatedSprite2D.sprite_frames.has_animation("death"))
	print("Frame count: ", $AnimatedSprite2D.sprite_frames.get_frame_count("death"))
	
	$AnimatedSprite2D.play("death")
	
	# Tunggu beberapa frame agar animasi terlihat
	await get_tree().process_frame
	await get_tree().process_frame
	
	print("Current animation: ", $AnimatedSprite2D.animation)
	print("Is playing: ", $AnimatedSprite2D.is_playing())
	
	# Gunakan timer manual karena animation_finished kadang tidak reliable
	var frame_count = $AnimatedSprite2D.sprite_frames.get_frame_count("death")
	var fps = $AnimatedSprite2D.sprite_frames.get_animation_speed("death")
	var duration = frame_count / float(fps)
	
	print("Duration: ", duration, " seconds")
	
	await get_tree().create_timer(duration).timeout
	
	print("Animation finished, removing enemy...")
	# Hapus enemy dari scene
	queue_free()

# Cooldown agar musuh tidak kena damage berulang terlalu cepat
func _on_take_damage_cooldown_timeout() -> void:
	can_take_damage = true
	
# Menampilkan dan memperbarui health bar musuh
func update_health():
	var healthbar = $healthbar
	healthbar.value = health
	
	if health >= 100:
		healthbar.visible = false
	else:
		healthbar.visible = true
