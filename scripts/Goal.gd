extends Area3D

signal goal_reached

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.name == "Player":
		goal_reached.emit()
		body.end_screen.visible = true
		body.end_screen.label_text = "Parabéns! Você chegou ao objetivo!"
