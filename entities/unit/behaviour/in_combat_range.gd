extends BTDecorator


@export var target_range := 1.0
@export var invert := false


func _tick(blackboard: Dictionary, delta: float) -> int:
	var unit: Unit = blackboard["unit"]

	var distance_squared: float = unit.global_position.distance_squared_to(unit.target.global_position)
	if distance_squared <= target_range ** 2 == !invert:
		return child_node._tick(blackboard, delta)
	
	return FAILURE
