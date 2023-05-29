extends Control

func _input(event):
	if event.is_action_pressed("pause"):
		pause_game()

func pause_game():
	var pause_state = not get_tree().paused
	get_tree().paused = pause_state
	visible = pause_state


func _on_continue_button_pressed():
	pause_game()
