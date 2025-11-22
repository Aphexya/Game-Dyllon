extends Panel

@onready var backgroundSprite: Sprite2D = $background
@onready var itemSprite: Sprite2D = $CenterContainer/Panel/item
@onready var amountLabel: Label = $CenterContainer/Panel/Label


func update(slot: InventorySlot):
	if not is_instance_valid(itemSprite) or not is_instance_valid(backgroundSprite):
		push_error("SlotGui: Sprite node tidak ditemukan!")
		return

	if !slot.item:
		backgroundSprite.frame = 0
		itemSprite.visible = false
		amountLabel.visible = false
	else:
		backgroundSprite.frame = 1
		itemSprite.visible = true
		itemSprite.texture = slot.item.icon
		amountLabel.visible = true
		amountLabel.text = str(slot.amount)

func _ready():
	self.connect("gui_input", Callable(self, "_on_gui_input"))


func _on_gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		_use_this_item()


func _use_this_item():
	var player = get_tree().root.get_node("dunia/Player")

	if player == null:
		print("PLAYER NOT FOUND")
		return

	var inventory = player.inventory

	if inventory == null:
		print("INVENTORY NOT FOUND")
		return

	var slot_index = get_index()
	var slot = inventory.slots[slot_index]

	inventory.use_item(slot, player)
