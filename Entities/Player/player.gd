extends CharacterBody3D


const SPEED = 5.0
const SENSITIVITY = .5

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


@onready var camera_pivot : Marker3D = $CameraPivot
@onready var visuals : Node3D = $Visuals


func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x) * SENSITIVITY) 
		camera_pivot.rotate_x(deg_to_rad(-event.relative.y) * SENSITIVITY)
		
		camera_pivot.rotation_degrees.x = clamp(camera_pivot.rotation_degrees.x, -70, 30)
	
	# For debugging purposes.
	if Input.is_action_just_released("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _physics_process(delta):
	velocity.y = -1 if is_on_floor() else velocity.y - gravity * delta
	
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED
	
	# This function already uses the delta time internally.
	move_and_slide()
