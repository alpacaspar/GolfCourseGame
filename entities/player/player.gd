extends CharacterBody3D


const SPEED = 5.0
const SENSITIVITY = .5

@onready var camera_pivot: Marker3D = $CameraPivot
@onready var visuals: Node3D = $Visuals

@export var camera: Camera3D
@export var input_provider: InputProvider
@export var state_machine: FSM

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")


func make_camera_current(value: bool):
	camera.current = value
