extends CharacterBody3D

signal light_turned_off
signal light_turned_on
signal light_off_time_updated(time_remaining: float)

@export var speed = 5.0
@export var rotation_speed = 10.0

@onready var animation_player: AnimationPlayer = $Player/AnimationPlayer
@onready var spot_light_3d: SpotLight3D = $SpotLight3D
@onready var timer: Timer = $Timer

var target_position: Vector3
var is_moving = false
var is_light_on = true
var light_off_timer: Timer
var death_delay = 5.0  # 5 segundos para morrer sem lanterna
var light_off_update_timer: Timer

func _ready():
	target_position = global_position
	
	# Timer para morte por falta de lanterna
	light_off_timer = Timer.new()
	light_off_timer.wait_time = death_delay
	light_off_timer.one_shot = true
	light_off_timer.timeout.connect(_on_light_off_timeout)
	add_child(light_off_timer)
	
	# Timer para atualizar a UI com o tempo restante
	light_off_update_timer = Timer.new()
	light_off_update_timer.wait_time = 0.1  # Atualizar a cada 0.1 segundos
	light_off_update_timer.timeout.connect(_update_light_off_time)
	add_child(light_off_update_timer)


func _input(event):
	if Input.is_action_just_pressed("lightControl"):
		toggle_light()
	
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

func toggle_light():
	is_light_on = !is_light_on
	spot_light_3d.visible = is_light_on
	
	# Gerenciar o timer de morte
	if is_light_on:
		light_off_timer.stop()
		light_off_update_timer.stop()
		light_turned_on.emit()
	else:
		light_off_timer.start()
		light_off_update_timer.start()
		light_turned_off.emit()

func turn_off_light():
	if is_light_on:
		is_light_on = false
		spot_light_3d.visible = false
		light_off_timer.start()
		light_off_update_timer.start()
		light_turned_off.emit()

func _update_light_off_time():
	if !is_light_on and light_off_timer.time_left > 0:
		light_off_time_updated.emit(light_off_timer.time_left)



func _on_light_off_timeout():
	# Morrer após 5 segundos sem lanterna
	die()

func die():
	# Parar o movimento
	is_moving = false
	velocity = Vector3.ZERO
	
	# Parar os timers
	if light_off_timer:
		light_off_timer.stop()
	if light_off_update_timer:
		light_off_update_timer.stop()
	
	# Tocar animação de morte
	if animation_player.has_animation("death"):
		animation_player.play("death")
	elif animation_player.has_animation("death_001"):
		animation_player.play("death_001")
	else:
		animation_player.play("Idle")
	
	# Desabilitar input
	set_process_input(false)
	set_physics_process(false) 
