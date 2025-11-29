extends Node2D

class_name Door   # optional, lebih bagus kalau ditambah

@export var required_keys := 3
@export var key_name := "Key Fragment"

var is_open := false

@onready var anim := $AnimatedSprite2D
@onready var door_collision := $StaticBody2D/CollisionShape2D

func _ready():
	set_meta("interactable", true)  # ← tambahan penting
	print("Door READY:", self.name)
	print("Door interact triggered")
	anim.play("idle")
	door_collision.disabled = false

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
		print("Butuh ", required_keys, "x ", key_name, " untuk membuka pintu.")

func open_door():
	is_open = true
	anim.play("open")


	# Hilangkan collision agar player bisa lewat
	door_collision.disabled = true  

	print("Pintu terbuka!")
