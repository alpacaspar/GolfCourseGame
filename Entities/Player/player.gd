extends CharacterBody3D


const SPEED = 5.0
const SENSITIVITY = .5

@onready var camera_pivot : Marker3D = $CameraPivot
@onready var visuals : Node3D = $Visuals

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


# For debugging purposes.
func _input(event):
	if Input.is_action_just_released("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
