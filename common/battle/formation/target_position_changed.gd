extends BTLeaf


@export var distance_threshold := 10.0

var last_position: Vector3 = Vector3.INF


func tick(blackboard: Dictionary, _delta: float):
	if not blackboard.has("target_position"):
		return FAILURE

	var target_position: Vector3 = blackboard["target_position"]

	var distance_squared := target_position.distance_squared_to(last_position)
	if distance_squared < distance_threshold * distance_threshold:
		return FAILURE

	last_position = target_position
	
	return SUCCESS
