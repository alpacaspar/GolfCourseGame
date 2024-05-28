extends BTAction


var strafe_influence := 0.5

var strafe_time := 0.0


func _tick(blackboard: Dictionary, _delta: float) -> int:
    var unit: Unit = blackboard["unit"]
    var navigation_agent: NavigationAgent3D = unit.controller.navigation_agent
    var target: Unit = blackboard["entities"].front()

    var direction_to_target: Vector3 = unit.global_position.direction_to(target.global_position)

    unit.controller.set_movement_target(target.global_position - direction_to_target * unit.role.attack_range)

    if navigation_agent.is_navigation_finished():
        unit.controller.set_velocity(Vector3.ZERO)
        return SUCCESS

    var next_path_position: Vector3 = navigation_agent.get_next_path_position()
    var new_velocity: Vector3 = unit.global_position.direction_to(next_path_position) * unit.role.move_speed

    unit.controller.set_velocity(new_velocity)

    return SUCCESS


func _get_strafe_direction(delta: float) -> int:
    strafe_time = fmod(strafe_time + delta * 0.2, 1.0)
    return sign(strafe_time * 2 - 1)
