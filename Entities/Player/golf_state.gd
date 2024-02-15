extends State


@export var golf_action : Node3D 


func _on_enter(_owner : FSM, _args = {}):
	golf_action.visible = true
	golf_action._initialize()


func _on_input(_event, _owner : FSM):
	pass


func _on_process(_delta, _owner : FSM):
	golf_action._on_process(_delta)


func _on_physics_process(_delta, _owner : FSM):
	pass


func _on_exit(_args = {}):
	golf_action.visible = false
