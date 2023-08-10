extends CanvasLayer

signal resume
signal exit

func _on_resume_button_pressed():
	resume.emit()

func _on_exit_button_pressed():
	exit.emit()
