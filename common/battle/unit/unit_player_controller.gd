extends Node3D


const SENSITIVITY = 0.3

@onready var input_provider: InputProvider = $InputProvider
@onready var camera_pivot: Marker3D = $CameraPivot

var body: CharacterBody3D

var last_velocity := Vector3.ZERO

## TODO: Use state machine to get rid of this ugly nasty gross dirty smelly bool.
var performing_swing: bool = false

func _ready():
	input_provider.on_look.connect(_on_look)
	input_provider.on_interact.connect(_on_interact)


func _on_look(input_delta: Vector2):
	body.rotate_y(deg_to_rad(-input_delta.x) * SENSITIVITY) 
	camera_pivot.rotate_x(deg_to_rad(input_delta.y) * SENSITIVITY)
	
	camera_pivot.rotation_degrees.x = clamp(camera_pivot.rotation_degrees.x, -70, 30)


func _on_interact():
	if performing_swing:
		return
	
	_do_the_swing()


func _physics_process(delta: float):
	body.visuals.look_in_direction(last_velocity, delta)

	var move_input: Vector2 = input_provider.move if not performing_swing else Vector2.ZERO

	body.velocity.y = -1 if body.is_on_floor() else body.velocity.y - body.gravity * delta

	var direction := (body.transform.basis * Vector3(-move_input.x, 0, -move_input.y)).normalized()

	body.velocity.x = direction.x * body.MOVEMENT_SPEED
	body.velocity.z = direction.z * body.MOVEMENT_SPEED

	# This function already uses the delta time internally.
	body.move_and_slide()

	if body.velocity:
		last_velocity = body.velocity


func _on_exit():
	input_provider.on_look.disconnect(_on_look)


func _do_the_swing():
	performing_swing = true
	body.perform_swing()

	await get_tree().create_timer(3).timeout

	performing_swing = false
