extends Node

var pause_menu: CanvasLayer = null
var btn_menu: Button = null

func register(pause_ui: CanvasLayer, btn: Button):
	pause_menu = pause_ui
	btn_menu = btn

func toggle_pause():
	if pause_menu == null or btn_menu == null:
		print("PauseManager: UI belum diregister!")
		return
	
	var new_state = !get_tree().paused
	get_tree().paused = new_state

	pause_menu.visible = new_state
	btn_menu.visible = !new_state
