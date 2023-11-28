extends "res://scripts/Mob.gd"
#Variável auxiliar para guardar a velocidade temporariamente
var temp_velocity

#Função de início
func _ready():
#Inicia a animação fly do Mob
	$Mob_Anim.play("fly")

#Função que spawna o Mob
func spawn(spawn_pos: Vector2, spawn_rot: float):
#Repete o funcionamento da função do script pai
	super(spawn_pos, spawn_rot)

#Dobra a velocidade do Mob
	linear_velocity *= 2
	temp_velocity = linear_velocity

	var wait_time = randf_range(0.2, 0.7)
	await get_tree().create_timer(wait_time).timeout

#Para o Mob após um tempo definido aleatoriamente. Depois faz com que continue
#na mesma direção
	linear_velocity = Vector2.ZERO

	wait_time = randf_range(0.5, 1.0)
	await get_tree().create_timer(wait_time).timeout

	linear_velocity = temp_velocity
