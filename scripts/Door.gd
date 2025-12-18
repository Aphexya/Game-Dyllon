extends Node2D
class_name Door   

# =====================================================
# KONFIGURASI PINTU
# required_keys → jumlah item yang dibutuhkan
# key_name      → nama item yang harus ada dalam inventory
# =====================================================
@export var required_keys := 3
@export var key_name := "Key Fragment"
@onready var dialog_door = get_tree().current_scene.get_node("DialogDoor/DialogDoor")

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
	print("dialog_door =", dialog_door)
	if is_open:
		return
	
	if dialog_door == null:
		push_error("DialogDoor BELUM di-assign di Inspector!")
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
		if dialog_door:
			dialog_door.show_message(
				"Kurasa pintu ini membutuhkan %d %s. \n" % [required_keys, key_name] +
				"Watashi baru punya %d." % count
			)


# =====================================================
# OPEN DOOR FUNCTION
# Menjalankan animasi buka pintu dan mematikan collision.
# =====================================================
func open_door():
	is_open = true
	anim.play("open")
	
	# Hilangkan collision agar player bisa lewat
	door_collision.disabled = true  
	if dialog_door:
		dialog_door.visible = false
		
	print("Pintu terbuka!")
