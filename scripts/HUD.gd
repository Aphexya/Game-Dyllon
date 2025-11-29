extends CanvasLayer

@onready var btn_menu: Button = $ButtonMenu
@onready var pause_menu: CanvasLayer = get_parent().get_node("PauseMenu")

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	btn_menu.pressed.connect(_on_menu_pressed)


func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		_toggle_pause()


func _on_menu_pressed():
	_toggle_pause()


func _toggle_pause():
	var paused = get_tree().paused

	# jika sedang paused → unpause
	if paused:
		get_tree().paused = false
		pause_menu.visible = false
		btn_menu.visible = true
	else:
		# jika sedang bermain → pause
		get_tree().paused = true
		pause_menu.visible = true
		btn_menu.visible = false
