extends BTLeaf


func _tick(blackboard: Dictionary, _delta: float) -> int:
	var target_position: Vector3 = blackboard["target_position"]
	blackboard["controller"].set_movement_target(target_position)

	return SUCCESS