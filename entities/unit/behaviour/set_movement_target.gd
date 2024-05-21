extends BTLeaf


func _tick(blackboard: Dictionary, _delta: float) -> int:
    var unit: Unit = blackboard["unit"]

    unit.controller.set_movement_target(unit.target.global_position)

    return SUCCESS
