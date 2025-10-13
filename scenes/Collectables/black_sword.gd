extends "res://scenes/Collectables/collectable.gd"

@onready var animations = $AnimationPlayer

func collect():
	print("Pedang dikolek, animasi diputar")
	animations.play("spin")
	await animations.animation_finished
	queue_free()
