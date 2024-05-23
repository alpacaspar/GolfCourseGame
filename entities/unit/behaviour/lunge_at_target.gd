extends BTAction


@export var distance_threshold := 1.0
@export var move_speed := 2.0


func _tick(blackboard: Dictionary, _delta: float) -> int:
    var unit: Unit = blackboard["unit"]
    var controller: Node = unit.controller

    var target_position_horizontal: Vector3 = unit.target.global_position
    target_position_horizontal.y = unit.global_position.y

    var target_direction: Vector3 = unit.global_position.direction_to(target_position_horizontal)
    var target_distance: float = unit.global_position.distance_to(target_position_horizontal)

    if target_distance <= distance_threshold:
        return SUCCESS

    controller._on_velocity_computed(target_direction * move_speed)
    
    return RUNNING
