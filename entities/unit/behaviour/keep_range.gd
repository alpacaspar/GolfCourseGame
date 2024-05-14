extends BTLeaf


@export var preferred_range := 4.0
@export var move_speed := 4.0


func _tick(blackboard: Dictionary, _delta: float) -> int:
    var unit: Unit = blackboard["unit"]
    var controller: Node = unit.controller
    var navigation_agent: NavigationAgent3D = controller.navigation_agent

    var target_position_horizontal: Vector3 = unit.target.global_position
    target_position_horizontal.y = unit.global_position.y

    var target_direction: Vector3 = unit.global_position.direction_to(target_position_horizontal)
    var target_distance: float = unit.global_position.distance_to(target_position_horizontal)

    var move_distance: float = target_distance - preferred_range

    controller.set_movement_target(unit.global_position + target_direction * move_distance)

    if not navigation_agent.is_navigation_finished():
        var next_path_position: Vector3 = navigation_agent.get_next_path_position()
        var new_velocity: Vector3 = controller.global_position.direction_to(next_path_position) * move_speed
        if navigation_agent.avoidance_enabled:
            navigation_agent.set_velocity(new_velocity)
        else:
            controller._on_velocity_computed(new_velocity)

    return SUCCESS
