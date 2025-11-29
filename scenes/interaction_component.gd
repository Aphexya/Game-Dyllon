extends Area2D

var can_interact: Array[Node] = []
@onready var parent = get_parent()

func _on_body_entered(body: Node) -> void:
	var interactable: Node = body

	# Cari parent sampai ketemu node yang punya method "interact"
	while interactable and !interactable.has_method("interact"):
		interactable = interactable.get_parent()

	if interactable and interactable.has_method("interact") and not can_interact.has(interactable):
		can_interact.append(interactable)
		print("REGISTERED INTERACTABLE:", interactable.name)


func _on_body_exited(body: Node) -> void:
	var interactable: Node = body

	while interactable and !interactable.has_method("interact"):
		interactable = interactable.get_parent()

	if interactable and can_interact.has(interactable):
		can_interact.erase(interactable)
		print("REMOVED INTERACTABLE:", interactable.name)


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		for obj in can_interact:
			print("INTERACT WITH:", obj.name)
			obj.interact(parent)
