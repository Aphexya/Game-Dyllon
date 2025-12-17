extends Area2D

var triggered := false

func _on_body_entered(body):
	if body.name != "player":
		return
	if triggered:
		return

	triggered = true

	var dialog = get_tree().current_scene.get_node("DialogMasuk/DialogMasuk")

	# Pause game
	get_tree().paused = true

	# Tampilkan dialog
	dialog.show_dialog()
