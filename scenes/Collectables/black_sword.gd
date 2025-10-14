extends "res://scenes/Collectables/collectable.gd"

@onready var animations = $AnimationPlayer

func collect(inventory: Inventory):
	print("Pedang dikolek, animasi diputar")
	animations.play("spin")
	await animations.animation_finished
	if inventory:
		inventory.insert(itemRes)
		print("✅ Pedang berhasil dimasukkan ke inventory:", itemRes)
	queue_free()
