extends Node3D


const SENSITIVITY = 0.3

@onready var input_provider: InputProvider = $InputProvider
@onready var camera_pivot: Marker3D = $CameraPivot

var unit: CharacterBody3D

var last_velocity := Vector3.ZERO

func _ready():
	input_provider.on_look.connect(_on_look)
	input_provider.on_interact.connect(_on_interact)


func _on_look(input_delta: Vector2):
	unit.rotate_y(deg_to_rad(-input_delta.x) * SENSITIVITY) 
	camera_pivot.rotate_x(deg_to_rad(input_delta.y) * SENSITIVITY)
	
	camera_pivot.rotation_degrees.x = clamp(camera_pivot.rotation_degrees.x, -70, 30)


func _on_interact():
	if unit.state == unit.ATTACKING:
		return
	
	_perform_action()


func _physics_process(delta: float):
	#unit.visuals.look_in_direction(last_velocity, delta)

	unit.velocity.y = -1 if unit.is_on_floor() else unit.velocity.y - unit.gravity * delta

	var direction := (unit.transform.basis * Vector3(-input_provider.move.x, 0, -input_provider.move.y)).normalized()

	unit.velocity.x = direction.x * unit.MOVE_SPEED
	unit.velocity.z = direction.z * unit.MOVE_SPEED

	# This function already uses the delta time internally.
	unit.move_and_slide()

	if unit.velocity:
		last_velocity = unit.velocity


func _on_exit():
	input_provider.on_look.disconnect(_on_look)


func _perform_action():
	unit.state = unit.ATTACKING
	unit.perform_action()

	await get_tree().create_timer(3).timeout

	unit.state = unit.IDLE
