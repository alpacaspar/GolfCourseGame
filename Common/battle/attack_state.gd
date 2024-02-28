class_name AttackState
extends State


@export var body: GolferBody

var target: Node3D


func _on_enter(_owner: FSM, msg := {}):
	target = msg.target


func _on_input(_event: InputEvent, _owner: FSM):
	pass


func _on_unhandled_input(_event: InputEvent, _owner: FSM):
	pass


func _on_process(_delta: float, _owner: FSM):
	pass


func _on_physics_process(_delta: float, _owner: FSM):
	if not target:
		_owner.transition_to("SearchState")
		return

	body.set_movement_target(target.global_transform.origin)


func _on_exit(_args := {}):
	pass
