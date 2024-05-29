extends BTAction


func _tick(blackboard: Dictionary, _delta: float) -> int:
    var unit: Unit = blackboard["unit"]
    var navigation_agent: NavigationAgent3D = unit.controller.navigation_agent

    if not blackboard.has("entities"):
        return FAILURE
    
    if blackboard["entities"].is_empty():
        return FAILURE

    unit.controller.set_movement_target(blackboard["entities"].front().global_position)

    if navigation_agent.is_navigation_finished():
        unit.controller.set_velocity(Vector3.ZERO)
        return SUCCESS

    var next_path_position: Vector3 = navigation_agent.get_next_path_position()
    var new_velocity: Vector3 = unit.global_position.direction_to(next_path_position) * unit.move_speed

    unit.controller.set_velocity(new_velocity)
    
    # make unit look in the direction of movement.

    return SUCCESS
