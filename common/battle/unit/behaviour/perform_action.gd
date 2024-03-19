extends BTLeaf


var swing_time := 4.0
var current_time := 0.0


func _tick(blackboard: Dictionary, delta: float) -> int:
	if not is_instance_valid(blackboard["target_unit"]):
		return FAILURE

	var direction_to_target: Vector3 = blackboard["controller"].global_position.direction_to(blackboard["target_unit"].global_position)
	blackboard["visuals"].look_in_dir(direction_to_target, delta)
	
	if current_time == 0:
		blackboard["controller"].body.perform_swing()
	
	current_time += delta
	if current_time >= swing_time:
		current_time = 0
		return SUCCESS
	else:
		return RUNNING



