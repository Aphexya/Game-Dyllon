extends CanvasLayer

@onready var label_time = $Control/Panel/LabelTime

func _ready():
	var t = GameTimer.get_time_data()

	label_time.text = "Time : %02d:%02d.%03d" % [t.minutes, t.seconds, t.msec]


func _on_back_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
