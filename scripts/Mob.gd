extends RigidBody2D

#Função de início
func _ready():
#Inicia a animação walk do Mob
	$Mob_Anim.play("walk")

#Função para detectar quando o Mob estiver fora da tela
func _on_visible_on_screen_enabler_2d_screen_exited():
#Deleta o Mob
	queue_free()

#Função que spawna o Mob
func spawn(spawn_pos: Vector2, spawn_rot: float):
#Recebe e define a posição e rotação inicial do Mob
	position = spawn_pos
	rotation = spawn_rot

#Define a velocidade de movimento do Mob
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	linear_velocity = velocity.rotated(spawn_rot)
