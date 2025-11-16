extends Node2D

@export var item: InventoryItem

func _ready():
	if item == null:
		print("ERROR: item kosong!")
	else:
		print("Item icon:", item.icon)

	if item.icon:
		$Sprite2D.texture = item.icon
	else:
		# Debug: biar kelihatan kalau icon hilang
		$Sprite2D.modulate = Color(1, 0, 0) # jadikan merah

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		print("Player mengambil item:", item.name)
		body.inventory.insert(item)
		queue_free()

func interact(player):
	if player.inventory:
		player.inventory.insert(item)
		queue_free()
