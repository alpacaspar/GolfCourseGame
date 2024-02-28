extends State


@export var golf_action: Node3D

var fsm_owner: FSM


func _on_enter(_owner: FSM, _args := {}):
	fsm_owner = _owner
	
	golf_action.visible = true
	golf_action._initialize(Callable(done))


func _on_input(_event: InputEvent, _owner: FSM):
	pass


func _on_process(_delta: float, _owner: FSM):
	golf_action._on_process(_delta)


func _on_physics_process(_delta: float, _owner: FSM):
	pass


func _on_exit(_args := {}):
	golf_action.visible = false


func done():
	fsm_owner.transition_state($"../MovementState")
