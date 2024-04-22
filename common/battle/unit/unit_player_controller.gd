extends Node3D


const SENSITIVITY = 0.3

@onready var input_provider: InputProvider = $InputProvider
@onready var camera_pivot: Marker3D = $CameraPivot

var unit: CharacterBody3D

var last_velocity := Vector3.ZERO

## TODO: Use state machine to get rid of this ugly nasty gross dirty smelly bool.
var performing_action: bool = false

func _ready():
	input_provider.on_look.connect(_on_look)
	input_provider.on_interact.connect(_on_interact)


func _on_look(input_delta: Vector2):
	unit.rotate_y(deg_to_rad(-input_delta.x) * SENSITIVITY) 
	camera_pivot.rotate_x(deg_to_rad(input_delta.y) * SENSITIVITY)
	
	camera_pivot.rotation_degrees.x = clamp(camera_pivot.rotation_degrees.x, -70, 30)


func _on_interact():
	if performing_action:
		return
	
	_perform_action()


func _physics_process(delta: float):
	unit.visuals.look_in_direction(last_velocity, delta)

	var move_input: Vector2 = input_provider.move if not performing_action else Vector2.ZERO

	unit.velocity.y = -1 if unit.is_on_floor() else unit.velocity.y - unit.gravity * delta

	var direction := (unit.transform.basis * Vector3(-move_input.x, 0, -move_input.y)).normalized()

	unit.velocity.x = direction.x * unit.MOVEMENT_SPEED
	unit.velocity.z = direction.z * unit.MOVEMENT_SPEED

	# This function already uses the delta time internally.
	unit.move_and_slide()

	if unit.velocity:
		last_velocity = unit.velocity


func _on_exit():
	input_provider.on_look.disconnect(_on_look)


func _perform_action():
	performing_action = true
	unit.perform_action()

	await get_tree().create_timer(3).timeout

	performing_action = false
