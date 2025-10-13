extends Node2D

var state = "chest_close"
var player_in_area = false

func _process(delta):
	if state == "chest_open":
		$AnimatedSprite2D.play("chest_open")
	elif state == "chest_close":
		$AnimatedSprite2D.play("chest_close")

	if player_in_area and Input.is_action_just_pressed("f") and state == "chest_close":
		state = "chest_open"
		print("Chest opened!") # debug line
		

func _on_pickable_area_body_entered(body):
	if body.is_in_group("player"):
		player_in_area = true
		print("Player in area") # debug line

func _on_pickable_area_body_exited(body):
	if body.is_in_group("player"):
		player_in_area = false
		print("Player left area") # debug line
