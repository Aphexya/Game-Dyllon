extends Resource
class_name Inventory

signal updated

@export var items: Array[InventoryItem] = []

func insert(item: InventoryItem):
	for i in range(items.size()):
		if !items[i]:
			items[i] = item
			updated.emit()
			return
	# jika inventory penuh
	items.append(item)
	updated.emit()
