extends BTLeaf


## Move in angle relative to the direction towards the target.
@export_range(0, 360) var angle: float = 0.0


func _tick(blackboard: Dictionary, delta: float) -> int:
    var unit: Unit = blackboard["unit"]
    var controller: Node = unit.controller

    var direction_to_target: Vector3 = controller.global_position.direction_to(blackboard["unit"].target.global_position)
    direction_to_target.y = 0
    direction_to_target = direction_to_target.normalized()
    var new_velocity := direction_to_target.rotated(Vector3.UP, deg_to_rad(angle)) * unit.movement_speed

    controller._on_velocity_computed(new_velocity)
    
    unit.visuals.look_in_direction(unit.velocity, delta)

    return SUCCESS
