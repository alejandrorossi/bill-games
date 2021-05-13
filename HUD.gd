extends CanvasLayer

signal start_game

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()
	
	
	
#	Esta función se llamará cuando el jugador pierde. Mostrará "Game Over"
#	 durante 2 segundos, luego volverá a la pantalla de título y revelará el botón "Start".
func show_game_over():
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	yield($MessageTimer, "timeout")
	$MessageLabel.text = "    El Coronavirus\n  bardeó zarpado y\n hay que sobrevivir."
	$MessageLabel.show()
	# Make a one-shot timer and wait for it to finish.
	yield(get_tree().create_timer(1), "timeout")
	$StartButton.show()

	
func update_life(life):
	$LifeLabel.text = str(life)
	

func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")

func _on_MessageTimer_timeout():
	$MessageLabel.hide()
