extends CanvasLayer

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	visible = false

	$Panel/MainButtons/Resume.pressed.connect(_on_resume)
	$Panel/MainButtons/MainMenu.pressed.connect(_on_main_menu)
	$Panel/MainButtons/ExitGame.pressed.connect(_on_exit_game)

func _on_resume():
	get_tree().paused = false
	self.visible = false
	if PauseManager.btn_menu:
		PauseManager.btn_menu.visible = true

func _on_main_menu():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_exit_game():
	get_tree().quit()
