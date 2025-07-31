extends Control

# As referências para os botões já estão corretas.
@onready var exit: Button = $PanelContainer/MarginContainer/HBoxContainer/Exit
@onready var try_again: Button = $PanelContainer/MarginContainer/HBoxContainer/TryAgain


func _ready():
	# Conecta o sinal "pressed" do botão 'exit' à função '_on_exit_pressed'.
	exit.pressed.connect(_on_exit_pressed)
	
	# Conecta o sinal "pressed" do botão 'try_again' à função '_on_try_again_pressed'.
	try_again.pressed.connect(_on_try_again_pressed)


# Esta função será chamada quando o botão 'Exit' for pressionado.
func _on_exit_pressed():
	print("Saindo do jogo...")
	get_tree().quit()


# Esta função será chamada quando o botão 'TryAgain' for pressionado.
func _on_try_again_pressed():
	print("Reiniciando a cena...")
	# A função reload_current_scene() recarrega a cena ativa no momento.
	get_tree().reload_current_scene()
