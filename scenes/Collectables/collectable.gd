extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":  # pastikan node Player bernama 'Player'
		print("Item dikolek:", name)
		collect()


func collect():
	queue_free()
	
