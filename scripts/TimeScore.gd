extends CanvasLayer

# Label penunjuk waktu (menit, detik, milidetik)
@onready var minutes_label = $TimerBoard/HBoxContainer/Minutes
@onready var seconds_label = $TimerBoard/HBoxContainer/Seconds
@onready var hsecs_label = $TimerBoard/HBoxContainer/Hsecs

# Fungsi ini dipanggil setiap frame.
# Digunakan untuk memperbarui tampilan timer secara real-time.
func _process(delta):
	var t = GameTimer.get_time_data()

	minutes_label.text = "%02d:" % t.minutes
	seconds_label.text = "%02d." % t.seconds
	hsecs_label.text = "%03d" % t.msec
