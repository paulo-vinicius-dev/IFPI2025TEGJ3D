extends Area3D

@export var speed = 15.0
@export var lifetime = 3.0
@export var direction = Vector3(0, 0, -1)

@onready var mesh_instance: MeshInstance3D = $MeshInstance3D
@onready var collision_shape: CollisionShape3D = $CollisionShape3D
@onready var timer: Timer = $Timer

func _ready():
	# Configurar o timer para destruir o projétil após o tempo de vida
	timer.wait_time = lifetime
	timer.timeout.connect(_on_timer_timeout)
	timer.start()
	
	# Conectar o sinal de área para detectar colisão com o player
	body_entered.connect(_on_body_entered)
	area_entered.connect(_on_area_entered)

func _physics_process(delta):
	# Mover o projétil na direção especificada
	global_position += direction * speed * delta

func _on_timer_timeout():
	queue_free()

func _on_body_entered(body):
	if body.has_method("turn_off_light"):
		body.turn_off_light()
	queue_free()

func _on_area_entered(area):
	var parent = area.get_parent()
	if parent.has_method("turn_off_light"):
		parent.turn_off_light()
	queue_free() 