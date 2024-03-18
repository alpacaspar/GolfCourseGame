extends BTLeaf


func _tick(blackboard: Dictionary, _delta: float) -> int:
	var controller: Node = blackboard["controller"]

	if controller.navigation_agent.is_navigation_finished():
		return SUCCESS

	var next_path_position: Vector3 = controller.navigation_agent.get_next_path_position()
	var wish_dir: Vector3 = controller.global_position.direction_to(next_path_position)
	
	var new_velocity: Vector3 = wish_dir.normalized() * controller.body.MOVEMENT_SPEED
	
	if controller.navigation_agent.avoidance_enabled:
		controller.navigation_agent.set_velocity(new_velocity)
	else:
		controller._on_velocity_computed(new_velocity)
	
	return RUNNING
