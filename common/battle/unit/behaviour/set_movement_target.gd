extends BTLeaf


func _tick(blackboard: Dictionary, _delta: float) -> int:
	blackboard["controller"].set_movement_target(blackboard["target_unit"].global_position)

	return SUCCESS
