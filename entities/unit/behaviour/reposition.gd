extends BTLeaf


var reposition_direction_positive := true


func _tick(blackboard: Dictionary, _delta: float) -> int:
	var unit: Unit = blackboard["unit"]
	var navigation_agent: NavigationAgent3D = unit.controller.navigation_agent
	
	var delta_to_target := unit.global_position - unit.target.global_position
	var direction_to_target := delta_to_target.normalized()
	var cross_from_target := direction_to_target.cross(Vector3.UP if reposition_direction_positive else Vector3.DOWN)
	
	unit.controller.set_movement_target(cross_from_target)

	if not navigation_agent.is_navigation_finished(): 
		var next_path_position: Vector3 = navigation_agent.get_next_path_position()
		var new_velocity: Vector3 = unit.global_position.direction_to(next_path_position) * 2
		if navigation_agent.avoidance_enabled:
			navigation_agent.set_velocity(new_velocity)
		else:
			unit.controller._on_velocity_computed(new_velocity)

	return SUCCESS


func _on_timer_timeout():
	reposition_direction_positive = !reposition_direction_positive
