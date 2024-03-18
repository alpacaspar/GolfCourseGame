extends BTLeaf


func _tick(blackboard: Dictionary, _delta: float) -> int:
	var target_position: Vector3 = blackboard["target_position"]

	var distance: float = blackboard["controller"].global_position.distance_squared_to(target_position)
	var desired_distance: float = blackboard["golfer"].role.desired_distance
	return SUCCESS if distance <= desired_distance * desired_distance else FAILURE
