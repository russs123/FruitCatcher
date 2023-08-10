extends CanvasLayer

signal restart
signal exit

#update contents of final score label
func update_final_score(score):
	$FinalScoreLabel.text = "Your Score: " + str(score)

func _on_restart_button_pressed():
	restart.emit()

func _on_exit_button_pressed():
	exit.emit()
