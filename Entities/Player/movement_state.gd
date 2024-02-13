extends State


@export var player : CharacterBody3D
@export var camera_pivot : Marker3D
@export var visuals : Node3D


func _on_enter(owner : FSM, _args = {}):
	pass


func _on_input(event, owner : FSM):
	if event is InputEventMouseMotion:
		player.rotate_y(deg_to_rad(-event.relative.x) * player.SENSITIVITY) 
		camera_pivot.rotate_x(deg_to_rad(-event.relative.y) * player.SENSITIVITY)
		
		camera_pivot.rotation_degrees.x = clamp(camera_pivot.rotation_degrees.x, -70, 30)


func _on_process(delta, owner : FSM):
	pass


func _on_physics_process(delta, owner : FSM):
	player.velocity.y = -1 if player.is_on_floor() else player.velocity.y - player.gravity * delta
	
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	player.velocity.x = direction.x * player.SPEED
	player.velocity.z = direction.z * player.SPEED
	
	# This function already uses the delta time internally.
	player.move_and_slide()


func _on_exit(_args = {}):
	pass
