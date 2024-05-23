extends BTAction


func _tick(blackboard: Dictionary, delta: float) -> int:
	if not blackboard["unit"].target:
		return FAILURE
	
	var target_position: Vector3 = blackboard["unit"].target.global_position

	var look_at_target_position := Vector3(target_position.x, blackboard["unit"].global_position.y, target_position.z)
	var look_direction: Vector3 = blackboard["unit"].global_position.direction_to(look_at_target_position)
	blackboard["unit"].visuals.look_in_direction(look_direction, delta)

	return SUCCESS
