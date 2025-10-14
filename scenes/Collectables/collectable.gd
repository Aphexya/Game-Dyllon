extends Area2D

@export var itemRes: InventoryItem

# helper: cek apakah objek punya properti bernama prop_name
func _has_property(obj: Object, prop_name: String) -> bool:
	for p in obj.get_property_list():
		# p adalah Dictionary berisi info property (mis. "name")
		if p.has("name") and p["name"] == prop_name:
			return true
	return false

func _on_body_entered(body: Node) -> void:
	if not body:
		return
	if body.name == "Player":
		print("Item dikolek:", name)
		# aman: periksa dulu apakah properti 'inventory' ada
		if _has_property(body, "inventory"):
			# sekarang aman mengakses body.inventory
			if body.inventory != null:
				collect(body.inventory)
			else:
				print("⚠️ Player punya property inventory, tapi nil/null")
		else:
			print("⚠️ Player tidak punya property 'inventory' — pastikan di-export atau di-assign di Inspector")

func collect(inventory: Inventory):
	if inventory:
		inventory.insert(itemRes)
		print("✅ Item berhasil dimasukkan ke inventory:", itemRes)
	queue_free()
