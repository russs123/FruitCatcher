extends CanvasLayer

signal start_game

#function to update the score
func update_score(score):
	$ScoreLabel.text = "Score: " + str(score)

#function to update the health bar
func update_health(new_health):
	$HealthBar.value = new_health

func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()
