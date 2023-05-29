extends CanvasLayer
signal start_game # Notify `Main` node that button has been pressed

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game Over")
	await $MessageTimer.timeout # Wait until MessageTimer has counted down.

	$Message.text = "Dodge the\nCreeps!"
	$Message.show()
	
	await get_tree().create_timer(1.0).timeout # Make one-shot timer and wait until it finishes.
	$StartButton.show()

func update_score(score):
	$ScoreLabel.text = str(score)
	
func _on_message_timer_timeout():
	$Message.hide()

func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()

