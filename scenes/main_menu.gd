extends Control

func _ready():
	global.current_scene = "main_menu"

	# matikan player kalau masih ada
	var player = get_tree().get_first_node_in_group("player")
	if player:
		player.queue_free()

	$Camera2D.enabled = true



func _on_start_pressed() -> void:
	global.current_scene = "world"
	get_tree().change_scene_to_file("res://scenes/dunia.tscn")


func _on_options_pressed() -> void:
	print("Options pressed")


func _on_exit_pressed() -> void:
	get_tree().quit()
