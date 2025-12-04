extends CharacterBody2D

@export var attack_damage = 25
@export var inventory: Inventory

# Script untuk mengatur perilaku player: gerak, serangan, kamera, dan kesehatan.
var enemy_inattack_range = false
var enemy_attack_cooldown = true
var max_health = 100
var health = 100
var player_alive = true

var current_enemy: Node = null

var attack_ip = false # status apakah player sedang menyerang

const kecepatan = 100
var arah = "diam" # arah pergerakan player terakhir



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
	#current_camera()
	update_health()
	
	# Jika health habis, player dianggap mati
	if health <= 0 and player_alive:
		player_alive = false
		health = 0
		$Audio/DeathSound.play()
		print("player has been killed")
		await get_tree().create_timer(0.5).timeout
		show_game_over()
		




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
	# FOOTSTEP SFX
	if is_moving and !$Audio/Footstep.playing:
		$Audio/Footstep.play()
	elif !is_moving:
		$Audio/Footstep.stop()

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

func set_camera_limit(tilemap: TileMap):
	await get_tree().process_frame

	var cam = $Camera2D
	print("Camera found? => ", cam)

	if cam == null:
		print("❌ Kamera tidak ditemukan! Cek Player di scene ini.")
		return

	

# Deteksi ketika musuh masuk ke area serangan player
# callback
func _on_player_hitbox_body_entered(body: Node2D):
	if body.has_method("enemy"):
		enemy_inattack_range = true
		current_enemy = body

func _on_player_hitbox_body_exited(body: Node2D):
	if body.has_method("enemy"):
		enemy_inattack_range = false
		if body == current_enemy:
			current_enemy = null


# Mengatur logika serangan musuh ke player
func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown and current_enemy != null:
		var dmg = current_enemy.attack_damage
		health -= dmg
		#$Audio/PlayerDamaged.play()
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		print("Player HP:", health, "took dmg:", dmg)



func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true


# Mengatur animasi dan logika saat player menyerang (BISA SAMBIL GERAK)
func attack():
	var arah_sekarang = arah
	
	if Input.is_action_just_pressed("attack"):
		$Audio/SwordSwing.play()
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

# Menampilkan dan memperbarui health bar player
func update_health():
	var healthbar = $healthbar
	healthbar.value = health

	if health >= max_health:
		healthbar.modulate.a = 3.0    # transparan saat full HP
	else:
		healthbar.modulate.a = 1.0    # solid saat HP berkurang


func heal(amount):
	health = min(health + amount, max_health)
	$Audio/HealSound.play()
	print("Healed:", amount, "HP =", health)
	

# Regenerasi health otomatis setiap timer berjalan
#func _on_regen_timer_timeout() -> void:
	#if health < 100:
		#health += 20
		#if health > 100:
			#health = 100
	#if health <= 0:
		#health = 0

# Respawn untuk kembali hidup lagi
func respawn():
	#$Audio/RespawnSound.play()

	var scene_name = global.current_scene
	var cp_pos = global.checkpoint_scene_pos.get(scene_name, Vector2(-999, -999))

	if cp_pos != Vector2(-999, -999):
		global_position = cp_pos
		print("Respawn ke CHECKPOINT:", cp_pos)
	else:
		global_position = Vector2(global.player_start_posx, global.player_start_posy)
		print("Respawn ke START POS:", global_position)

	health = max_health
	player_alive = true
	
func show_game_over():
	var game_over_scene = preload("res://scenes/GameOver.tscn").instantiate()
	get_tree().current_scene.add_child(game_over_scene)
	global.player_can_move = false
