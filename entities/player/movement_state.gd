extends State


@export var player: CharacterBody3D


func _on_enter(_msg := {}):	
	player.input_provider.on_look.connect(_on_look)
	player.make_camera_current(true)


func _on_process(_delta: float):
	pass


func _on_look(input_delta: Vector2):
	player.rotate_y(deg_to_rad(-input_delta.x) * player.SENSITIVITY) 
	player.camera_pivot.rotate_x(deg_to_rad(-input_delta.y) * player.SENSITIVITY)
	
	player.camera_pivot.rotation_degrees.x = clamp(player.camera_pivot.rotation_degrees.x, -70, 30)


func _on_physics_process(delta: float):
	var move_input = player.input_provider.move
	
	player.velocity.y = -1 if player.is_on_floor() else player.velocity.y - player.gravity * delta
	
	var direction = (player.transform.basis * Vector3(move_input.x, 0, move_input.y)).normalized()
	
	player.velocity.x = direction.x * player.SPEED
	player.velocity.z = direction.z * player.SPEED
	
	# This function already uses the delta time internally.
	player.move_and_slide()


func _on_exit():
	player.input_provider.on_look.disconnect(_on_look)
