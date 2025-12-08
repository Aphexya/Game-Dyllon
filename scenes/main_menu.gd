extends Control
@onready var main_buttons: VBoxContainer = $MainButtons
@onready var settings: Panel = $Settings

func _ready():
	if not $AudioStreamPlayer.playing:
		$AudioStreamPlayer.play()
	main_buttons.visible = true
	settings.visible = false
	
	global.current_scene = "main_menu"
	
	# matikan player kalau masih ada
	var player = get_tree().get_first_node_in_group("player")
	if player:
		player.queue_free()

	$Camera2D.enabled = true
	

	
func _on_start_pressed() -> void:
	var intro = load("res://scenes/IntroStory.tscn").instantiate()
	add_child(intro)
	main_buttons.visible = false

func _on_settings_pressed() -> void:
	print("Settings")
	main_buttons.visible = false
	settings.visible = true

func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_back_pressed() -> void:
	main_buttons.visible = true
	settings.visible = false
