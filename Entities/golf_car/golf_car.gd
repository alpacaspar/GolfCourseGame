extends VehicleBody3D


const FORCE_MULTIPLIER = 800
const MAX_STEERING = 0.3
const STEERING_DELTA = 4
const SENSITIVITY = 0.3

@onready var input_provider: InputProvider = $InputProvider
@onready var camera_pivot: Marker3D = $CameraPivot

var rot_x := 0.0
var rot_y := 0.0

var controller: Node3D


func _ready():
	input_provider.on_look.connect(_on_look)
	input_provider.on_interact.connect(_on_interact)


func _physics_process(delta):
	var input_dir = input_provider.move
	
	steering = lerp(steering, -input_dir.x * MAX_STEERING, STEERING_DELTA * delta)
	engine_force = input_dir.y * FORCE_MULTIPLIER


func _on_look(input_delta: Vector2):
	rot_x += input_delta.x * SENSITIVITY
	rot_y += input_delta.y * SENSITIVITY

	camera_pivot.transform.basis = Basis()
	camera_pivot.rotate_object_local(Vector3.UP, -deg_to_rad(rot_x))
	camera_pivot.rotate_object_local(Vector3.RIGHT, -deg_to_rad(rot_y))


func _on_interact():
	controller.set_visible(true)
	controller.global_position = global_position

	InputManager.set_active_provider(controller.input_provider)


func _on_interactable_interacted(_interactor: Interactor):
	InputManager.set_active_provider(input_provider)

	controller = _interactor.controller
	controller.set_visible(false)
