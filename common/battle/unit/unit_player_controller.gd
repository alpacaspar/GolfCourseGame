extends Node3D


const SENSITIVITY = 0.3

@onready var input_provider: InputProvider = $InputProvider
@onready var camera_pivot: Marker3D = $CameraPivot

@export var camera: Camera3D

var body: CharacterBody3D


func _ready():
	input_provider.on_look.connect(_on_look)


func _on_look(input_delta: Vector2):
	body.rotate_y(deg_to_rad(-input_delta.x) * SENSITIVITY) 
	camera_pivot.rotate_x(deg_to_rad(-input_delta.y) * SENSITIVITY)
	
	camera_pivot.rotation_degrees.x = clamp(camera_pivot.rotation_degrees.x, -70, 30)


func _physics_process(delta: float):
	var move_input = input_provider.move

	body.velocity.y = -1 if body.is_on_floor() else body.velocity.y - body.gravity * delta

	var direction = (body.transform.basis * Vector3(move_input.x, 0, move_input.y)).normalized()

	body.velocity.x = direction.x * body.MOVEMENT_SPEED
	body.velocity.z = direction.z * body.MOVEMENT_SPEED

	# This function already uses the delta time internally.
	body.move_and_slide()


func _on_exit():
	input_provider.on_look.disconnect(_on_look)


func make_camera_current(value: bool):
	camera.current = value
