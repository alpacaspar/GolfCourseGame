extends BTLeaf


func _tick(blackboard: Dictionary, delta: float) -> int:
    var unit: Unit = blackboard["unit"]
    var controller: Node = unit.controller
    var navigation_agent: NavigationAgent3D = controller.navigation_agent

    controller.set_movement_target(blackboard["unit"].target.global_position)

    if not navigation_agent.is_navigation_finished():
        var next_path_position: Vector3 = navigation_agent.get_next_path_position()
        var new_velocity: Vector3 = controller.global_position.direction_to(next_path_position) * unit.movement_speed
        if navigation_agent.avoidance_enabled:
            navigation_agent.set_velocity(new_velocity)
        else:
            controller._on_velocity_computed(new_velocity)
        
        unit.visuals.look_in_direction(unit.velocity, delta)

    return SUCCESS
