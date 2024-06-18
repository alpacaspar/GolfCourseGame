extends BTAction


@export var input_array: StringName = "entities"

var strafe_time := 0.0


func _tick(blackboard: Dictionary, delta: float) -> int:
    var unit: Unit = blackboard["unit"]
    var navigation_agent: NavigationAgent3D = unit.controller.navigation_agent
    var target: Node3D = blackboard[input_array].front()

    var direction_to_target: Vector3 = unit.global_position.direction_to(Vector3(target.global_position.x, unit.global_position.y, target.global_position.z))
    var cross_to_target := direction_to_target.cross(Vector3.UP)

    var movement_target: Vector3 = target.global_position
    movement_target += -direction_to_target * unit.role.attack_range
    movement_target += cross_to_target * _get_strafe_direction(delta)

    unit.controller.set_movement_target(movement_target)

    if navigation_agent.is_navigation_finished():
        unit.controller.set_velocity(Vector3.ZERO)
        return SUCCESS

    var next_path_position: Vector3 = navigation_agent.get_next_path_position()
    var new_velocity: Vector3 = unit.global_position.direction_to(next_path_position) * 2

    unit.controller.set_velocity(new_velocity)

    return SUCCESS


func _get_strafe_direction(delta: float) -> int:
    strafe_time = fmod(strafe_time + delta * 0.2, 2.0)
    return roundi(strafe_time) - 1
