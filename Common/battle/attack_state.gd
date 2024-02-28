class_name AttackState
extends State


@export var body: GolferBody


func _on_enter(_msg := {}):
	pass

func _on_input(_event: InputEvent):
	pass


func _on_unhandled_input(_event: InputEvent):
	pass


func _on_process(_delta: float):
	pass


func _on_physics_process(_delta: float):
	if not body.target:
		fsm_owner.transition_to("SearchState")
		return

	body.set_movement_target(body.target.global_transform.origin)


func _on_exit(_msg := {}):
	pass
