extends Control

@onready var instructions: Label = $Instructions
@onready var light_status: Label = $LightStatus
@onready var time_remaining: Label = $TimeRemaining

var player: CharacterBody3D

func _ready():
	if instructions:
		instructions.text = "Clique com o botão esquerdo do mouse para mover o personagem\n\nObjetivo: Chegue ao cubo verde!\n\nPressione L para ligar/desligar a lanterna"
	
	# Encontrar o jogador na cena
	player = get_tree().get_first_node_in_group("player")
	if !player:
		# Tentar encontrar por nome
		player = get_node_or_null("../Player")
	
	if player:
		player.light_turned_off.connect(_on_light_turned_off)
		player.light_turned_on.connect(_on_light_turned_on)
		player.light_off_time_updated.connect(_on_light_off_time_updated)
	
	# Configurar labels iniciais
	if light_status:
		light_status.text = "Lanterna: LIGADA"
		light_status.modulate = Color.GREEN
	if time_remaining:
		time_remaining.text = ""

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ESCAPE:
			get_tree().quit()

func _on_light_turned_off():
	if light_status:
		light_status.text = "Lanterna: APAGADA!"
		light_status.modulate = Color.RED
	if time_remaining:
		time_remaining.text = "Tempo restante: 5.0s"

func _on_light_turned_on():
	if light_status:
		light_status.text = "Lanterna: LIGADA"
		light_status.modulate = Color.GREEN
	if time_remaining:
		time_remaining.text = ""

func _on_light_off_time_updated(time_left: float):
	if time_remaining and time_left > 0:
		time_remaining.text = "Tempo restante: %.1fs" % time_left
		# Mudar cor baseada no tempo restante
		if time_left > 3.0:
			time_remaining.modulate = Color.YELLOW
		elif time_left > 1.0:
			time_remaining.modulate = Color.ORANGE
		else:
			time_remaining.modulate = Color.RED 
