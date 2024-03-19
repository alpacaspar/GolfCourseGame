extends BTLeaf


const DISTANCE_THRESHOLD = 2.5

var last_target_unit_position := Vector3.INF 


func _tick(blackboard: Dictionary, _delta: float) -> int:
	var target_unit: Unit = blackboard["target_unit"]

	var squared_distance := target_unit.global_position.distance_squared_to(last_target_unit_position)
	if squared_distance < DISTANCE_THRESHOLD * DISTANCE_THRESHOLD:
		return FAILURE
	
	last_target_unit_position = target_unit.global_position

	return SUCCESS