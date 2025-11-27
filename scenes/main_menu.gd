extends Control
@onready var main_buttons: VBoxContainer = $MainButtons
@onready var options: Panel = $Options

func _ready():
	$AudioStreamPlayer.play()
	main_buttons.visible = true
	options.visible = false
	
	global.current_scene = "main_menu"
	
	# matikan player kalau masih ada
	var player = get_tree().get_first_node_in_group("player")
	if player:
		player.queue_free()

	$Camera2D.enabled = true
	

	
func _on_start_pressed() -> void:
	global.current_scene = "world"
	GameTimer.start()
	get_tree().change_scene_to_file("res://scenes/dunia.tscn")


func _on_options_pressed() -> void:
	print("Options pressed")
	main_buttons.visible = false
	options.visible = true

func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_back_options_pressed() -> void:
	_ready()
