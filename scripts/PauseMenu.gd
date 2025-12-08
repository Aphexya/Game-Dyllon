extends CanvasLayer

@onready var main_buttons: VBoxContainer = $Panel/MainButtons
@onready var settings: Panel = $Panel/Settings
@onready var back_button: Button = $Panel/Settings/Back


# ---------------------------------------------------------
# Fungsi awal ketika PauseMenu dibuat
# ---------------------------------------------------------
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	visible = false

	# tampilkan menu utama saat pause dibuka
	main_buttons.visible = true
	settings.visible = false

	# koneksi tombol
	$Panel/MainButtons/Resume.pressed.connect(_on_resume)
	$Panel/MainButtons/MainMenu.pressed.connect(_on_main_menu)
	$Panel/MainButtons/Settings.pressed.connect(_on_settings)
	back_button.pressed.connect(_on_back_settings_pressed)

# ---------------------------------------------------------
# Tombol Resume → lanjutkan game
# ---------------------------------------------------------
func _on_resume():
	get_tree().paused = false
	visible = false

	if PauseManager.btn_menu:
		PauseManager.btn_menu.visible = true

# ---------------------------------------------------------
# Tombol Settings → tampilkan panel pengaturan
# ---------------------------------------------------------
func _on_settings():
	print("Settings pressed")
	main_buttons.visible = false
	settings.visible = true

# ---------------------------------------------------------
# Tombol Main Menu → keluar ke main_menu.tscn
# ---------------------------------------------------------
func _on_main_menu():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

# ---------------------------------------------------------
# Tombol Back di Settings → kembali ke menu utama
# ---------------------------------------------------------
func _on_back_settings_pressed():
	main_buttons.visible = true
	settings.visible = false
