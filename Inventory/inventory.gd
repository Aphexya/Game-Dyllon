extends Resource
class_name Inventory

signal updated

@export var slots: Array[InventorySlot] = []

func insert(item: InventoryItem):
	var itemSlots = slots.filter(func(slot): return slot.item == item)
	if !itemSlots.is_empty():
		itemSlots[0].amount += 1
	else:
		var emptySlots = slots.filter(func(slot): return slot.item == null)
		if !emptySlots.is_empty():
			emptySlots[0].item = item
			emptySlots[0].amount = 1
		else:
			# Jika inventory penuh, buat slot baru
			var new_slot = InventorySlot.new()
			new_slot.item = item
			new_slot.amount = 1
			slots.append(new_slot)
			
	updated.emit()

func use_item(slot: InventorySlot, player):
	if slot.item == null:
		print("NO ITEM IN SLOT")
		return
	
	print("Using item:", slot.item.name)
	print("Effect type:", slot.item.effect_type)
	print("Effect value:", slot.item.effect_value)
	print("Using item:", slot.item.name)
	print("Effect:", slot.item.effect_type, slot.item.effect_value)

	match slot.item.effect_type:
		"heal":
			player.heal(slot.item.effect_value)

	slot.amount -= 1
	if slot.amount <= 0:
		slot.item = null

	updated.emit()
