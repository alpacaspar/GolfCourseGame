extends BTCondition


@export var input_array: StringName = "entities"
@export var range_threshold := 10.0


func _check_condition(blackboard: Dictionary) -> bool:
	if not blackboard.has(input_array):
		return false

	var closest_distance_squared := INF

	for entity: Node3D in blackboard[input_array]:
		var distance := entity.global_position.distance_squared_to(entity.global_position)

		if distance < closest_distance_squared:
			closest_distance_squared = distance

	return closest_distance_squared < range_threshold * range_threshold
