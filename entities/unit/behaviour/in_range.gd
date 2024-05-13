extends BTDecorator


@export var distance_tolerance := 2.0
@export var invert := false


func _tick(blackboard: Dictionary, delta: float) -> int:
	var unit: Unit = blackboard["unit"]
	var controller: Node = unit.controller
	var navigation_agent: NavigationAgent3D = controller.navigation_agent

	var distance_squared: float = unit.global_position.distance_squared_to(unit.target.global_position)
	var distance_diff: float = abs(distance_squared - navigation_agent.target_desired_distance ** 2)
	if distance_diff <= distance_tolerance ** 2 == !invert:
		return child_node._tick(blackboard, delta)
	
	return FAILURE
