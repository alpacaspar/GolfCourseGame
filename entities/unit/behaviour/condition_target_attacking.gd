extends BTCondition


## Threshold for when the attack is considered to be directed at the unit in degrees.
@export_range(0, 180) var attack_angle_threshold := 45.0


func _check_condition(blackboard: Dictionary) -> bool:
    var unit: Unit = blackboard["unit"]
    var target: Node3D = blackboard["entities"].front()

    if not target.is_attacking:
        return false

    var direction_from_target: Vector3 = target.global_position.direction_to(Vector3(unit.global_position.x, target.global_position.y, unit.global_position.z))
    var target_forward := target.global_basis.z

    if direction_from_target.angle_to(target_forward) > deg_to_rad(attack_angle_threshold):
        return false

    return true
