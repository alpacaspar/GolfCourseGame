extends BTLeaf


func _tick(blackboard: Dictionary, delta: float) -> int:
	var unit: Unit = blackboard["unit"]
	var controller: Node = unit.controller
	var navigation_agent: NavigationAgent3D = controller.navigation_agent
	
	if blackboard.has("performing_action") and blackboard["performing_action"]:
		navigation_agent.set_velocity(Vector3.ZERO)
		return SUCCESS

	var distance_squared: float = unit.global_position.distance_squared_to(blackboard["target"].global_position)
	if distance_squared < navigation_agent.target_desired_distance ** 2:
		return SUCCESS

	controller.set_movement_target(blackboard["target"].global_position)
	
	if not navigation_agent.is_navigation_finished():
		var next_path_position: Vector3 = navigation_agent.get_next_path_position()
		var new_velocity: Vector3 = controller.global_position.direction_to(next_path_position) * unit.MOVEMENT_SPEED
		if navigation_agent.avoidance_enabled:
			navigation_agent.set_velocity(new_velocity)
		else:
			controller._on_velocity_computed(new_velocity)
		
		unit.visuals.look_in_direction(unit.velocity, delta)
	
	return RUNNING
