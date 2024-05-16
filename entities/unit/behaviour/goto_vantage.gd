extends BTLeaf


@export var preferred_distance := 30.0


func _tick(blackboard: Dictionary, delta: float) -> int:
    var unit: Unit = blackboard["unit"]
    var controller: Node = unit.controller
    var navigation_agent: NavigationAgent3D = controller.navigation_agent

    var target_direction := unit.global_position.direction_to(unit.target.global_position)
    var distance_to_target := unit.global_position.distance_to(unit.target.global_position)

    var target_position: Vector3 = unit.global_position + target_direction * (distance_to_target - preferred_distance)

    controller.set_movement_target(target_position)

    if navigation_agent.is_navigation_finished():
        return SUCCESS
    
    var next_path_position: Vector3 = navigation_agent.get_next_path_position()
    var new_velocity: Vector3 = controller.global_position.direction_to(next_path_position) * unit.MOVE_SPEED
    if navigation_agent.avoidance_enabled:
        navigation_agent.set_velocity(new_velocity)
    else:
        controller._on_velocity_computed(new_velocity)
    
    unit.visuals.look_in_direction(unit.velocity, delta)

    return RUNNING
