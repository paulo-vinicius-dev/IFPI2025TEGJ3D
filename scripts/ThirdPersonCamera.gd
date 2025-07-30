extends Camera3D

@export var target: Node3D
@export var distance = 6.0
@export var height = 2.0
@export var smooth_speed = 5.0
@export var rotation_speed = 2.0

var camera_rotation = 0.0
var is_rotating = false
var target_position: Vector3

func _ready():
	if target:
		update_camera_position()

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			if event.pressed:
				is_rotating = true
			else:
				is_rotating = false
	
	if event is InputEventMouseMotion and is_rotating:
		camera_rotation += event.relative.x * rotation_speed * 0.01

func _physics_process(delta):
	if target:
		update_camera_position()
		global_position = global_position.lerp(target_position, smooth_speed * delta)
		look_at(target.global_position + Vector3(0, 1, 0))

func update_camera_position():
	if target:
		var target_global_pos = target.global_position
		
		# Calcula a posição da câmera com rotação
		var camera_offset = Vector3(
			sin(camera_rotation) * distance,
			height,
			cos(camera_rotation) * distance
		)
		
		target_position = target_global_pos - camera_offset 