extends BTLeaf


@export var flee_time := 5.0


var current_time := 0.0


func _tick(blackboard: Dictionary, delta: float) -> int:
	var unit: Unit = blackboard["unit"]
	var controller: Node = unit.controller
	var navigation_agent: NavigationAgent3D = controller.navigation_agent

	current_time += delta

	if current_time >= flee_time:
		current_time = 0.0
		return SUCCESS

	var flee_direction := Vector3.ZERO

	for opponent: Unit in BattleManager.get_opponent_units(unit.team):
		flee_direction += -unit.global_position.direction_to(opponent.global_position)

	flee_direction.y = 0
	flee_direction = flee_direction.normalized()

	controller.set_movement_target(unit.global_position + flee_direction * 10.0)

	if not navigation_agent.is_navigation_finished(): 
		var next_path_position: Vector3 = navigation_agent.get_next_path_position()
		var new_velocity: Vector3 = controller.global_position.direction_to(next_path_position) * unit.MOVE_SPEED
		if navigation_agent.avoidance_enabled:
			navigation_agent.set_velocity(new_velocity)
		else:
			controller._on_velocity_computed(new_velocity)

		unit.visuals.look_in_direction(unit.velocity, delta)
	
	return RUNNING
