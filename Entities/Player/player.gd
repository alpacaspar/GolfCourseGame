extends CharacterBody3D


const SPEED = 5.0
const SENSITIVITY = .5

@onready var camera_pivot : Marker3D = $CameraPivot
@onready var visuals : Node3D = $Visuals

@export var state_machine : FSM

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


# For debugging purposes.
func _input(_event):
	if Input.is_action_just_released("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if Input.is_action_just_pressed("TestKey"):
		state_machine._transition_state($FiniteStateMachine/GolfState)
	
	if Input.is_action_just_pressed("TestKey2"):
		state_machine._transition_state($FiniteStateMachine/MovementState)
