extends StaticBody2D

@export var items: Dictionary[InventoryItem, int] = {}
@onready var animations: AnimationPlayer = $AnimationPlayer
@onready var item_start_pos: Vector2 = $ItemStartPos.position
@onready var item_end_pos: Vector2 = $ItemEndPos.position

var is_open: bool = false

func interact(interacter: Node2D) -> void:
	if is_open: return
	
	var inventory = interacter.get("inventory")
	if !inventory || inventory is not Inventory: return
	
	is_open = true
	animations.play("open")
	await animations.animation_finished
	spawn_andcollect(interacter)

func spawn_andcollect(interacter: Node2D) -> void:
	for i: InventoryItem in items:
		for a in range(items[i]):
			var sprite := Sprite2D.new()
			sprite.texture = i.icon
			sprite.position = item_start_pos
			sprite.z_index = interacter.z_index + 1
			add_child(sprite)

			var tween = create_tween().set_trans(Tween.TRANS_ELASTIC)
			tween.tween_property(sprite, "position", item_end_pos, 0.3)
			await tween.finished

			var tween_collect = create_tween()
			tween_collect.tween_property(sprite, "global_position", interacter.global_position, 0.4)
			tween_collect.tween_callback(func ():
				sprite.queue_free()
				
				# 🔽 Buat instance InventoryItem dari InventoryItem
				var new_item := i.duplicate(true)



				# lalu masukkan ke inventory
				interacter.inventory.insert(new_item)
			)
