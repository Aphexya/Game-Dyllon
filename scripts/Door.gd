extends Node2D
class_name Door   

# =====================================================
# KONFIGURASI PINTU
# required_keys → jumlah item yang dibutuhkan
# key_name      → nama item yang harus ada dalam inventory
# =====================================================
@export var required_keys := 3
@export var key_name := "Key Fragment"

var is_open := false

@onready var anim := $AnimatedSprite2D
@onready var door_collision := $StaticBody2D/CollisionShape2D


# =====================================================
# READY FUNCTION
# Dipanggil saat pintu muncul. Mengatur animasi awal dan
# memastikan collision aktif.
# =====================================================
func _ready():
	set_meta("interactable", true)  # ← tambahan penting
	print("Door READY:", self.name)
	print("Door interact triggered")
	anim.play("idle")
	door_collision.disabled = false


# =====================================================
# INTERACT FUNCTION
# Dipanggil saat player menekan tombol interaksi.
# Mengecek inventory player apakah memiliki item yang cukup.
# =====================================================
func interact(player):
	print("PLAYER interacts with DOOR")
	if is_open:
		return
	
	var inv = player.inventory
	if inv == null:
		return
	print("--- DEBUG INVENTORY ---")
	for slot in inv.slots:
		if slot.item:
			print("Item:", slot.item.name, " Amount:", slot.amount)
	print("-------------------------")

	var count = inv.get_item_count(key_name)

	if count >= required_keys:
		open_door()
	else:
		# Tampilkan pesan jelas di log
		print("❗ Membutuhkan ", required_keys, "x ", key_name, " untuk membuka pintu.")
		print("   → Kamu hanya punya: ", count, "x ", key_name)


# =====================================================
# OPEN DOOR FUNCTION
# Menjalankan animasi buka pintu dan mematikan collision.
# =====================================================
func open_door():
	is_open = true
	anim.play("open")


	# Hilangkan collision agar player bisa lewat
	door_collision.disabled = true  

	print("Pintu terbuka!")
