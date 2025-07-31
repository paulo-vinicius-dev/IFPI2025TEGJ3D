extends Control

# As referências para os botões já estão corretas.
@onready var exit: Button = $PanelContainer/MarginContainer/HBoxContainer/Exit
@onready var try_again: Button = $PanelContainer/MarginContainer/HBoxContainer/TryAgain
@onready var label: Label = $PanelContainer/Label

var label_text: String = "" : set = set_label_text

func set_label_text(novo_texto: String):
	label_text = novo_texto
	if label:
		label.text = label_text

func _ready():	
	label.text = label_text
	exit.pressed.connect(_on_exit_pressed)
	
	try_again.pressed.connect(_on_try_again_pressed)


# Esta função será chamada quando o botão 'Exit' for pressionado.
func _on_exit_pressed():
	print("Saindo do jogo...")
	get_tree().quit()


# Esta função será chamada quando o botão 'TryAgain' for pressionado.
func _on_try_again_pressed():
	print("Reiniciando a cena...")
	get_tree().reload_current_scene()
