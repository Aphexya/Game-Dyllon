extends CanvasLayer

@onready var label_time = $Control/Panel/LabelTime

# =====================================================
# READY FUNCTION
# Dipanggil saat Victory Screen muncul.
# - Memastikan musik kemenangan diputar.
# - Mengambil data waktu dari GameTimer dan menampilkannya
#   dalam format menit:detik.milidetik.
# =====================================================
func _ready():
	if not $AudioStreamPlayer.playing:
		$AudioStreamPlayer.play()
	var t = GameTimer.get_time_data()

	label_time.text = "Time : %02d:%02d.%03d" % [t.minutes, t.seconds, t.msec]


# =====================================================
# TOMBOL "BACK TO MENU"
# - Ketika ditekan, langsung kembali ke Main Menu.
# =====================================================
func _on_back_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
