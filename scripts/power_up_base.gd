extends Area2D

#Função de início que spawna um Power Up numa posição aleatória na tela
func _ready():
	position = Vector2(randi_range(10, 470), randi_range(10, 710))

#Função genérica para guardar o efeito do Power Up
func activate_powerup():
	pass

#Função que detecta áreas sobrepostas à do Power Up
func _on_area_entered(area):
#Ao detectar sobreposição de áreas, esconde e desabilita o Power Up. Depois ativa
#o efeito do mesmo
	hide()
	$CollisionShape2D.set_deferred("disabled", true)
	activate_powerup()
