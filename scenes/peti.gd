extends StaticBody2D

@onready var animations: AnimationPlayer = $AnimationPlayer

var is_open: bool = false

func interact() -> void:
	if is_open: return
	is_open = true
	animations.play("open")
