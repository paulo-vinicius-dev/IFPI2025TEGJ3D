extends Control

@onready var instructions: Label = $Instructions

var player: CharacterBody3D

func _ready():
	if instructions:
		instructions.text = "Clique com o botão esquerdo do mouse para mover o personagem\n\nObjetivo: Chegue ao cubo verde!\n\nNão deixe os cospidores de água apagarem sua lanterna\nO escuro é perigoso"
	
	# Encontrar o jogador na cena
	player = get_tree().get_first_node_in_group("player")
	if !player:
		# Tentar encontrar por nome
		player = get_node_or_null("../Player")
		
func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ESCAPE:
			get_tree().quit()
