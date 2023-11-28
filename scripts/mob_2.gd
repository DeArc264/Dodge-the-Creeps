extends "res://scripts/Mob.gd"


#Função de início
func _ready():
#Inicia a animação swim do Mob
	$Mob_Anim.play("swim")

#Função que spawna o Mob
func spawn(spawn_pos: Vector2, spawn_rot: float):
#Repete o funcionamento da função do script pai
	super(spawn_pos, spawn_rot)

#Faz o Mob parar de se mover após um tempo definido aleatoriamente. Depois
#altera a rotação do Mob e faz com que se mova novamente
	var wait_time = randf_range(1.5, 2.0)
	await get_tree().create_timer(wait_time).timeout

	$Mob_Anim.rotate(PI/2)
	linear_velocity = linear_velocity.rotated(PI/2)
