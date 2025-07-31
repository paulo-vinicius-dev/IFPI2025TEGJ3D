extends Area3D

signal goal_reached

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.name == "Player":
		goal_reached.emit()
		print("Parabéns! Você chegou ao objetivo!") 
