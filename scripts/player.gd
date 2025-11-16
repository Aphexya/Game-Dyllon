extends CharacterBody2D

# Script untuk mengatur perilaku player: gerak, serangan, kamera, dan kesehatan.
var enemy_inattack_range = false
var enemy_attack_cooldown = true
var health = 100
var player_alive = true

var attack_ip = false # status apakah player sedang menyerang

const kecepatan = 100
var arah = "diam" # arah pergerakan player terakhir

@export var inventory: Inventory

func _ready():
	add_to_group("player")
	print("Player groups:", get_groups())


# Fungsi utama yang dipanggil setiap frame
func _physics_process(delta):
	if !global.player_can_move: # kode gerakan player
		return
	gerak_player(delta)
	enemy_attack()
	attack()
	current_camera()
	update_health()
	
	# Jika health habis, player dianggap mati
	if health <= 0:
		player_alive = false
		health = 0
		print("player has been killed")
		respawn()  # ganti dari queue_free() jadi panggil respawn()


# Mengatur gerakan player dan animasi saat bergerak
func gerak_player(delta):
	var is_moving = false
	
	if Input.is_action_pressed("ui_right"):
		arah = "kanan"
		velocity.x = kecepatan * delta * 60
		velocity.y = 0
		is_moving = true
	elif Input.is_action_pressed("ui_left"):
		arah = "kiri"
		velocity.x = -kecepatan * delta * 60
		velocity.y = 0
		is_moving = true
	elif Input.is_action_pressed("ui_up"):
		arah = "atas"
		velocity.x = 0
		velocity.y = -kecepatan * delta * 60
		is_moving = true
	elif Input.is_action_pressed("ui_down"):
		arah = "bawah"
		velocity.x = 0
		velocity.y = kecepatan * delta * 60
		is_moving = true
	else:
		# Jika tidak menekan tombol gerak
		velocity.x = 0
		velocity.y = 0
		is_moving = false
	
	# Update animasi hanya jika tidak sedang menyerang
	if !attack_ip:
		arah_player(is_moving)
	
	move_and_slide()


# Mengatur animasi sesuai arah dan status gerak
func arah_player(gerak):
	var arah_sekarang = arah
	var animasi = $AnimatedSprite2D

	if arah_sekarang == "kanan":
		animasi.flip_h = false
		if gerak:
			animasi.play("jalan_kanan")
		else:
			animasi.play("diam")
	elif arah_sekarang == "kiri":
		animasi.flip_h = true
		if gerak:
			animasi.play("jalan_kiri")
		else:
			animasi.play("diam")
	elif arah_sekarang == "atas":
		if gerak:
			animasi.play("jalan_atas")
		else:
			animasi.play("diam")
	elif arah_sekarang == "bawah":
		if gerak:
			animasi.play("jalan_bawah")
		else:
			animasi.play("diam")


func player():
	pass # hanya sebagai penanda bahwa ini node Player


# Deteksi ketika musuh masuk ke area serangan player
func _on_player_hitbox_body_entered(body: Node2D):
	if body.has_method("enemy"):
		enemy_inattack_range = true

func _on_player_hitbox_body_exited(body: Node2D):
	if body.has_method("enemy"):
		enemy_inattack_range = false


# Mengatur logika serangan musuh ke player
func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown == true:
		health -= 50
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		print(health)


func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true


# Mengatur animasi dan logika saat player menyerang (BISA SAMBIL GERAK)
func attack():
	var arah_sekarang = arah
	
	if Input.is_action_just_pressed("attack"):
		global.player_current_attack = true
		attack_ip = true
		
		# Mainkan animasi attack sesuai arah
		if arah_sekarang == "kanan":
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("side_attack")
		elif arah_sekarang == "kiri":
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("side_attack")
		elif arah_sekarang == "bawah":
			$AnimatedSprite2D.play("front_attack")
		elif arah_sekarang == "atas":
			$AnimatedSprite2D.play("back_attack")
		
		$deal_attack_timer.start()


# Reset status serangan setelah animasi selesai
func _on_deal_attack_timer_timeout() -> void:
	global.player_current_attack = false
	attack_ip = false
	# Tidak perlu start timer lagi karena sudah one-shot


# Mengaktifkan kamera sesuai scene aktif
func current_camera():
	# Jika masih di main menu → semua kamera OFF
	if global.current_scene == "main_menu":
		$world_camera.enabled = false
		$cliffside_camera.enabled = false
		return
		
	# Jika di world
	if global.current_scene == "world":
		$world_camera.enabled = true
		$cliffside_camera.enabled = false
		return

	# Jika di cliff_side
	if global.current_scene == "cliff_side":
		$world_camera.enabled = false
		$cliffside_camera.enabled = true
		return




# Menampilkan dan memperbarui health bar player
func update_health():
	var healthbar = $healthbar
	healthbar.value = health
	
	if health >= 100:
		healthbar.visible = false
	else:
		healthbar.visible = true


# Regenerasi health otomatis setiap timer berjalan
func _on_regen_timer_timeout() -> void:
	if health < 100:
		health += 20
		if health > 100:
			health = 100
	if health <= 0:
		health = 0

# Respawn untuk kembali hidup lagi
func respawn():
	await get_tree().create_timer(0.5).timeout  # beri jeda 0.5 detik
	if global.checkpoint_pos != Vector2(-999, -999):
		global_position = global.checkpoint_pos
	else:
		global_position = Vector2(global.player_start_posx, global.player_start_posy)

	health = 100
	player_alive = true
	print("Respawned at:", global_position)
