extends State


@export var golf_action : Node3D 

var fsm_owner


func _on_enter(_owner : FSM, _args = {}):
	fsm_owner = _owner
	var callable = Callable(self, "done")
	
	golf_action.visible = true
	golf_action._initialize(callable)


func _on_input(_event, _owner : FSM):
	pass


func _on_process(_delta, _owner : FSM):
	golf_action._on_process(_delta)


func _on_physics_process(_delta, _owner : FSM):
	pass


func _on_exit(_args = {}):
	golf_action.visible = false


func done():
	fsm_owner._transition_state($"../MovementState")
