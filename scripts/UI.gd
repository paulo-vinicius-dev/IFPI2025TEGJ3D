extends Control

func _ready():
	$Instructions.text = "Clique com o botão esquerdo do mouse para mover o personagem\n\nObjetivo: Chegue ao cubo verde!"

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ESCAPE:
			get_tree().quit() 
