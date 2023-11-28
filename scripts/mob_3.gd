extends "res://scripts/Mob.gd"

@onready var tween

#Função de início
func _ready():
#Inicia a animação fly do Mob
	$Mob_Anim.play("fly")

#Função que spawna o Mob
func spawn(spawn_pos: Vector2, spawn_rot: float):
#Repete o funcionamento da função do script pai
	super(spawn_pos, spawn_rot)

#Toca a animação fade do Mob, tornando-o invisivel por um curto tempo.
	$FadeAnimation.play("fade")
