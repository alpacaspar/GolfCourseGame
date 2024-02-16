extends State


var current_angle : float = 0

@export var angle_visuals : Node3D
@export var angle_camera_holder : Node3D
@export var golf_action : Node3D


func _on_enter(_owner : FSM, _args = {}):
	angle_visuals.visible = true


func _on_process(_delta, _owner : FSM):
	if Input.is_action_pressed("move_left"):
		current_angle += .01
	if Input.is_action_pressed("move_right"):
		current_angle -= .01


func _on_physics_process(_delta, _owner : FSM):
	angle_visuals.rotate(Vector3.UP, current_angle)
	angle_camera_holder.rotate(Vector3.UP, current_angle)
	current_angle = 0


func _on_exit(_args = {}):
	angle_visuals.visible = false
	golf_action.current_angle = -angle_visuals.global_basis.z
