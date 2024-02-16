extends State


var currentAngle : float = 0

@export var angleVisuals : Node3D
@export var angle_camera : Node3D
@export var golf_action : Node3D


func _on_enter(_owner : FSM, _args = {}):
	angleVisuals.visible = true


func _on_process(_delta, _owner : FSM):
	if Input.is_action_pressed("move_left"):
		currentAngle += .01
	if Input.is_action_pressed("move_right"):
		currentAngle -= .01


func _on_physics_process(_delta, _owner : FSM):
	angleVisuals.rotate(Vector3.UP, currentAngle)
	angle_camera.rotate(Vector3.UP, currentAngle)
	currentAngle = 0


func _on_exit(_args = {}):
	angleVisuals.visible = false
	golf_action.currentAngle = -angleVisuals.global_basis.z
