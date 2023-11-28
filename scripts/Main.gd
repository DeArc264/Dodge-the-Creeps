extends Node

#Variáveis que recebem as diferentes cenas de Mobs e Power Ups
@export var mob_scene: Array[PackedScene]
@export var powerUp_scene: Array[PackedScene]

#Variáveis para armazenar o valor atual da Pontuação e quanto deve ser adicionado
#da próxima vez que o ScoreTimer chegar à zero
var score
var addScore = 1

#Função que toca a cada frame
func _process(_delta):
#Checa se o jogador pressionou o botão de Pause
	if Input.is_action_just_pressed("pause"):
	#Mostra o Menu de Pause
		$PauseHUD.pause_menu()
		$PauseHUD.show()

	#Para o timer de spawn de Mobs, Pontuação e Power Ups
		$MobTimer.stop()
		$ScoreTimer.stop()
		$PowerUpTimer.stop()
	#Pausa as físicas da cena
		get_tree().paused = true

#Função para iniciar uma nova partida
func new_game():
#Garante que o jogo não esteja pausado ao iniciar
	get_tree().paused = false

#Torna a Pontuação atual zero
	score = 0

#Inicia o jogador na posição do Node StartPosition
	$Player.start($StartPosition.position)

#Inicia o timer que inicia o jogo
	$StartTimer.start()

#Muda o texto de Pontuação da HUD e mostra mensagem de início
	$HUD.update_score(score)
	$HUD.show_message("Get Ready!")

#Deleta qualquer Mob que restou da partida anterior
	get_tree().call_group("mobs", "queue_free")

#Inicia a música de fundo
	$BGMusic.play()

#Função de Game Over
func game_over():
#Parar temporizadores de Mobs, Pontos e Power Ups
	$MobTimer.stop()
	$ScoreTimer.stop()
	$PowerUpTimer.stop()

#Mostrar tela de Game Over
	$HUD.show_game_over()

#Parar música de fundo e tocar música de Game Over
	$BGMusic.stop()
	$GOMusic.play()

#Função chamada quando MobTimer chega à zero
func _on_mob_timer_timeout():
#Variável que armazena uma cena aleatória do Array mob_scene
	var mob : RigidBody2D = mob_scene.pick_random().instantiate()

#Adiciona o novo Mob selecionado na Cena
	add_child(mob)

#Define o ponto de spawn do novo Mob
	$MobPath/MobSpawn.progress_ratio = randf()

#Define a direção a direção padrão para o novo Mob
	var direction = $MobPath/MobSpawn.rotation_degrees + 90

#Escolhe um ângulo para o qual o novo Mob aponta
	direction = randf_range(-PI/4,PI/4)

#Chama a função spawn do novo Mob
	mob.spawn(%MobSpawn.position, direction)

#Função chamada quando ScoreTimer chega a zero
func _on_score_timer_timeout():
#Aumenta o valor de score pelo valor definido em addScore. Depois atualiza a
#pontuação na HUD
	score += addScore
	$HUD.update_score(score)

#Função chamada quando StartTimer chega a zero
func _on_start_timer_timeout():
#Inicia todos os outros Timers
	$MobTimer.start()
	$ScoreTimer.start()
	$PowerUpTimer.start()

#Função chamada quando o jogador sai do Menu de Pause
func resume_game():
#Reinicia os Timers de spawn de Mobs e Power Ups
	$MobTimer.start()
	$ScoreTimer.start()

#Reinicia a física da Cena
	get_tree().paused = false

#Função chamada para reiniciar o jogo
func restart_game():
#Reinicia a Cena atual
	get_tree().reload_current_scene()

#Função que para a música do jogo
func _on_pause_hud_silence():
#Checa se a música está tocando. Se estiver, para. Se não, inicia
	if $BGMusic.playing == true:
		$BGMusic.stop()
	else:
		$BGMusic.play()

#Função chamada quando PowerUpTimer chega a zero
func _on_power_up_timer_timeout():
#Variável que armazena uma cena aleatória do Array powerUp_scene
	var pU : Area2D = powerUp_scene.pick_random().instantiate()

#Adiciona o novo Power Up selecionado na Cena
	add_child(pU)

#Checa se a Cena adicionada possui o sinal especificado. Caso sim, o conecta
#à Cena.
	if pU.has_signal("double"):
		pU.connect("double", more_points)

#Função chamada quando o sinal double é chamado
func more_points():
#Aumenta o valor adicionado por segundo à pontuação por dez segundos. Depois
#retorna ao valor original
	addScore = 2
	await get_tree().create_timer(10.0).timeout
	addScore = 1
