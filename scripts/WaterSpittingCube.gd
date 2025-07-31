extends Node3D

@export var water_speed = 15.0
@export var spit_interval = 2.0
@export var water_lifetime = 3.0
@export var spit_direction = Vector3(0, 0, -1)  # Direção padrão: para frente

@onready var timer: Timer = $Timer
@onready var water_spawn_point: Node3D = $WaterSpawnPoint

var water_scene = preload("res://scenes/WaterProjectile.tscn")

func _ready():
	timer.wait_time = spit_interval
	timer.timeout.connect(_on_timer_timeout)
	timer.start()

func _on_timer_timeout():
	spit_water()

func spit_water():
	var water = water_scene.instantiate()
	get_tree().current_scene.add_child(water)
	
	# Posicionar o projétil de água no ponto de spawn
	water.global_position = water_spawn_point.global_position
	
	# Definir a direção do projétil
	water.direction = spit_direction.normalized()
	water.speed = water_speed
	water.lifetime = water_lifetime 