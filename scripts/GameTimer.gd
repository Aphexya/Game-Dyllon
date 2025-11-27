extends Node

var time: float = 0.0
var running: bool = false

func start():
	time = 0.0
	running = true

func stop():
	running = false

func _process(delta):
	if running:
		time += delta

func get_time_data():
	var msec = int(fmod(time, 1) * 100)
	var seconds = int(fmod(time, 60))
	var minutes = int(time / 60)
	return {
		"minutes": minutes,
		"seconds": seconds,
		"msec": msec
	}
