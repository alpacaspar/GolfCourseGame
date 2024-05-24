extends BTAction


@export var angle_threshold := 1.0


func _tick(blackboard: Dictionary, delta: float) -> int:
    var unit: Unit = blackboard["unit"]
    var target: Unit = blackboard["entities"].front()
    
    if not target or not is_instance_valid(target) or target.is_exhausted():
        return FAILURE

    var unit_forward := unit.get_global_transform().basis.z

    var target_position_adjusted := Vector3(target.global_position.x, unit.global_position.y, target.global_position.z)
    var direction_to_target := unit.global_position.direction_to(target_position_adjusted)

    if unit_forward.angle_to(direction_to_target) < angle_threshold:
        return SUCCESS

    var angle := atan2(direction_to_target.x, direction_to_target.z)
    unit.global_rotation.y = rotate_toward(unit.global_rotation.y, angle, delta)

    return RUNNING