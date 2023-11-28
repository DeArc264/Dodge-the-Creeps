extends "res://scripts/power_up_base.gd"

#Função de início
func _ready():
#Imita a função ready do script pai
	super()

#Deleta todos os objetos na Cena dentro do grupo mobs
func activate_powerup():
	get_tree().call_group("mobs", "queue_free")
