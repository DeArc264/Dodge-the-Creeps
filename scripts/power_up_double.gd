extends "res://scripts/power_up_base.gd"
#Sinal para auxiliar a função de efeito do Power Up
signal double

#Função de início
func _ready():
#Imita a função ready do script pai
	super()

#Emite o sinal double
func activate_powerup():
	double.emit()
