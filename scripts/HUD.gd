extends CanvasLayer

#Sinal emitido para iniciar uma partida
signal start_game

#Função para alterar a mensagem mostrada na HUD
func show_message(text: String):
#Recebe, atualiza e mostra uma mensagem específica na tela. Depois inicia o Timer.
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

#Função para mostrar o texto de Game Over na tela
func show_game_over():
	#Altera o texto na tela para Game Over. Depois, espera o Timer chegar a zero
	show_message("Game Over!")
	await $MessageTimer.timeout

#Retorna ao Menu Principal e mostra os botões depois de 1 segundo
	$Message.text = "Dogde The\nCreeps!"
	$Message.show()

	await get_tree().create_timer(1.0).timeout
	$Start.show()
	$Quit.show()

#Funçao que retorna ao Menu Principal
func return_to_menu():
#Altera o texto na tela e mostra tanto ele quanto os botões
	$Message.text = "Dogde The\nCreeps!"
	$Message.show()

	$Start.show()
	$Quit.show()

#Função para atualizar a Pontuação na tela
func update_score(score):
#Altera o número mostrado para o valor recebido
	$ScoreLabel.text = str(score)

#Função chamada quando o jogador clica em Jogar
func _on_start_pressed():
#Esconde os botões do Menu e emite o sinal start_game
	$Start.hide()
	$Quit.hide()
	start_game.emit()

#Função chamada quando o Timer chega à zero
func _on_message_timer_timeout():
#Esconde o texto na tela
	$Message.hide()


func _on_quit_pressed():
	get_tree().quit()
