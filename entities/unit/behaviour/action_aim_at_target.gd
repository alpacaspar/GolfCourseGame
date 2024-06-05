extends BTAction


## The threshold at which the unit is considered to be facing the target, in degrees.
@export var angle_threshold := 1.0
@export var aim_rotation_delta := 1.0


func _tick(blackboard: Dictionary, delta: float) -> int:
    var unit: Unit = blackboard["unit"]
    var target: Node3D = blackboard["entities"].front()
    
    if not target or not is_instance_valid(target) or target.is_exhausted():
        return FAILURE

    var unit_forward: Vector3 = unit.controller.global_basis.z

    var target_position_adjusted := Vector3(target.global_position.x, unit.global_position.y, target.global_position.z)
    var direction_to_target := unit.global_position.direction_to(target_position_adjusted)

    if unit_forward.angle_to(direction_to_target) < deg_to_rad(angle_threshold):
        return SUCCESS

    var angle := atan2(direction_to_target.x, direction_to_target.z)
    unit.controller.global_rotation.y = rotate_toward(unit.controller.global_rotation.y, angle, aim_rotation_delta * delta)

    return RUNNING
