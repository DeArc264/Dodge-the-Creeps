extends CanvasLayer

#Sinais criados para auxiliar as funções
signal resume
signal restart
signal silence

#Função de início
func _ready():
#Esconde todo o Menu de Pause ao iniciar
	$Pause.hide()
	$VBoxContainer.hide()
	$TimeLabel.hide()

#Função chamada constantemente
func _process(_delta):
#Atualiza o texto na tela para mostrar os segundos restantes do Timer
	$TimeLabel.text = str(int($ResumeTimer.time_left))

#Função chamada ao clicar em Resume
func _on_resume_button_pressed():
#Esconde o Menu de Pause e mostra o tempo restante até que o jogo volte a
#funcionar. Depois inicia o Timer
	$Pause.hide()
	$VBoxContainer.hide()
	$MusicButton.hide()
	$TimeLabel.show()
	$ResumeTimer.start(3.0)

#Função chamada quando o Timer chega a zero
func _on_resume_timer_timeout():
#Esconde o texto que mostra o Timer e emite o sinal resume
	$TimeLabel.hide()
	resume.emit()

#Função chamada ao clicar em Restart
func _on_restart_button_pressed():
#Emite o sinal restart
	restart.emit()

#Função chamada ao clicar em Quit
func _on_quit_button_pressed():
#Encerra a aplicação
	get_tree().quit()

#Função para mostrar o Menu de Pause
func pause_menu():
#Mostra o texto e botões do Menu de Pause
	$Pause.show()
	$VBoxContainer.show()

#Função chamada ao clicar em MusicButton
func _on_texture_button_pressed():
#Emite o sinal silence
	silence.emit()
