extends State


var current_angle : float = 0

@export var angle_visuals : Node3D
@export var angle_camera_holder : Node3D
@export var golf_action : Node3D


func _on_enter(_owner : FSM, _args = {}):
	angle_visuals.rotation = Vector3.ZERO
	angle_camera_holder.rotation = Vector3.ZERO
	angle_visuals.visible = true


func _on_process(_delta, _owner : FSM):
	current_angle += Input.get_axis("move_left", "move_right") * 0.01


func _on_physics_process(_delta, _owner : FSM):
	angle_visuals.rotate(Vector3.UP, current_angle)
	angle_camera_holder.rotate(Vector3.UP, current_angle)
	current_angle = 0


func _on_exit(_args = {}):
	angle_visuals.visible = false
	golf_action.current_angle = -angle_visuals.global_basis.z
