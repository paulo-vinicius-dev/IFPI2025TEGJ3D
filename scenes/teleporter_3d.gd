# Teleporter3D.gd
extends Area3D

## Define o tipo do teletransporte: Entrada ou Saída.
## A lógica de teletransporte só é ativada nas Entradas.
enum Type { ENTRY, EXIT }
@export var type: Type = Type.ENTRY

# Esta função é chamada automaticamente quando um corpo entra na área.
# Precisamos conectar este sinal ao nosso script.
func _on_body_entered(body: Node3D):
	# 1. A lógica só deve rodar em teletransportes de ENTRADA.
	if type != Type.ENTRY:
		return

	# 2. Verificamos se o corpo que entrou é o jogador.
	#    É uma boa prática usar grupos para identificar o jogador também.
	#    Adicione seu nó de jogador (ex: CharacterBody3D) ao grupo "player".
	if not body.is_in_group("player"):
		return
	
	var all_teleporters = get_tree().get_nodes_in_group("teleporters")
	
	var exits = []
	for teleporter in all_teleporters:
		if teleporter.type == Type.EXIT and teleporter != self:
			# Vamos imprimir o nome de cada saída válida que encontrarmos
			exits.append(teleporter)
				
	# 4. Se existirem saídas disponíveis...
	if not exits.is_empty():
		# Escolhe uma saída aleatória da lista
		var random_exit = exits.pick_random()
		
		# Teletransporta o corpo para a posição global da saída!
		# A propriedade 'global_position' funciona perfeitamente para nós 3D.
		body.global_position = random_exit.global_position
		print("Teletransportado para: ", random_exit.name)
	else:
		# Alerta caso nenhuma saída seja encontrada.
		print("AVISO: Teletransporte de entrada não encontrou nenhuma saída!")
