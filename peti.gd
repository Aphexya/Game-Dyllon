extends StaticBody2D

@onready var animations: AnimationPlayer = $AnimationPlayer

func interact() ->void:
	animations.play("open")
