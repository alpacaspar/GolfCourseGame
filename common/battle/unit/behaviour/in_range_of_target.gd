extends BTLeaf


func tick(blackboard: Dictionary, _delta: float) -> int:
	var navigation_agent: NavigationAgent3D = blackboard["unit"].controller.navigation_agent
	
	var distance_squared: float = blackboard["unit"].global_position.distance_squared_to(blackboard["target"].global_position)
	if distance_squared < navigation_agent.target_desired_distance ** 2:
		return SUCCESS
	
	return FAILURE