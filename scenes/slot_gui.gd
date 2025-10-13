extends Panel

@onready var backgroundSprite: Sprite2D = $background
@onready var itemSprite: Sprite2D = $CenterContainer/Panel/item

func update(item: InventoryItem):
	if not is_instance_valid(itemSprite) or not is_instance_valid(backgroundSprite):
		push_error("SlotGui: Sprite node tidak ditemukan!")
		return

	if item:
		backgroundSprite.frame = 0
		itemSprite.visible = true
		itemSprite.texture = item.texture
	else:
		backgroundSprite.frame = 1
		itemSprite.visible = false
