extends CharacterBody3D

@export var speed = 5.0
@export var rotation_speed = 10.0

@onready var animation_player: AnimationPlayer = $Player/AnimationPlayer
@onready var spot_light_3d: SpotLight3D = $SpotLight3D
@onready var timer: Timer = $Timer

var target_position: Vector3
var is_moving = false

func _ready():
	target_position = global_position

func _input(event):
	if Input.is_action_just_pressed("lightControl"):
		spot_light_3d.visible = !spot_light_3d.visible
	
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var camera = get_node("Camera3D")
		var mouse_pos = get_viewport().get_mouse_position()
		
		var from = camera.project_ray_origin(mouse_pos)
		var to = from + camera.project_ray_normal(mouse_pos) * 1000
		
		var space_state = get_world_3d().direct_space_state
		var query = PhysicsRayQueryParameters3D.create(from, to)
		var result = space_state.intersect_ray(query)
		
		if result:
			target_position = result.position
			target_position.y = global_position.y
			is_moving = true

func _physics_process(delta):
	if is_moving:
		animation_player.play("run_001")
		var direction = (target_position - global_position)
		direction.y = 0
		
		if direction.length() > 0.1:
			# Rotacionar o jogador na direção do movimento
			var target_rotation = atan2(direction.x, direction.z)
			var current_rotation = rotation.y
			var rotation_diff = target_rotation - current_rotation
			
			# Normalizar o ângulo
			while rotation_diff > PI:
				rotation_diff -= 2 * PI
			while rotation_diff < -PI:
				rotation_diff += 2 * PI
			
			rotation.y = lerp_angle(current_rotation, target_rotation, rotation_speed * delta)
			
			# Mover o jogador
			velocity = direction.normalized() * speed
			move_and_slide()
		else:
			animation_player.play("idle")
			velocity = Vector3.ZERO
			is_moving = false
			
	else:
		velocity = Vector3.ZERO 
