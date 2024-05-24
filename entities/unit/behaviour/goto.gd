extends BTLeaf


@export var avoidance_radius := 2.0


func _tick(blackboard: Dictionary, delta: float) -> int:
	var unit: Unit = blackboard["unit"]
	var controller: Node = unit.controller
	var navigation_agent: NavigationAgent3D = controller.navigation_agent

	if not navigation_agent.is_navigation_finished():
		var next_path_position: Vector3 = navigation_agent.get_next_path_position()
		var new_velocity: Vector3 = unit.global_position.direction_to(next_path_position) * unit.MOVE_SPEED

		new_velocity += _get_avoidance(unit, unit.team.get_active_units())
		
		if navigation_agent.avoidance_enabled:
			navigation_agent.set_velocity(new_velocity)
		else:
			controller._on_velocity_computed(new_velocity)
		
		unit.visuals.look_in_direction(unit.velocity, delta)

	return SUCCESS


func _get_avoidance(unit: Unit, other_units: Array[Unit]) -> Vector3:
	var avoidance := Vector3.ZERO

	for other_unit: Unit in other_units:
		if other_unit == unit:
			continue

		var distance_squared: float = unit.global_position.distance_squared_to(other_unit.global_position)
		if distance_squared < avoidance_radius ** 2:
			avoidance += unit.global_position.direction_to(other_unit.global_position)
	
	return -avoidance / max(other_units.size() - 1, 1)
