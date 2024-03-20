extends BTLeaf


func _tick(blackboard: Dictionary, _delta: float) -> int:
	var target_unit: Unit = blackboard["target_unit"]

	var distance_squared: float = blackboard["controller"].global_position.distance_squared_to(target_unit.global_position)
	var desired_distance: float = blackboard["golfer"].role.desired_distance

	return SUCCESS if distance_squared <= desired_distance * desired_distance else FAILURE
