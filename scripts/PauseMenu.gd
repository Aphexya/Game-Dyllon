extends CanvasLayer

@onready var main_buttons: VBoxContainer = $Panel/MainButtons
@onready var options: Panel = $Panel/Options
@onready var back_button: Button = $Panel/Options/Back

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	visible = false

	# tampilkan menu utama saat pause dibuka
	main_buttons.visible = true
	options.visible = false

	# koneksi tombol
	$Panel/MainButtons/Resume.pressed.connect(_on_resume)
	$Panel/MainButtons/MainMenu.pressed.connect(_on_main_menu)
	$Panel/MainButtons/Options.pressed.connect(_on_options)
	back_button.pressed.connect(_on_back_options_pressed)

func _on_resume():
	get_tree().paused = false
	visible = false

	if PauseManager.btn_menu:
		PauseManager.btn_menu.visible = true

func _on_options():
	print("Options pressed")
	main_buttons.visible = false
	options.visible = true

func _on_main_menu():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_back_options_pressed():
	main_buttons.visible = true
	options.visible = false
