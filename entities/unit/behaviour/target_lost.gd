extends BTDecorator


func _tick(blackboard: Dictionary, delta: float) -> int:
    var unit: Unit = blackboard["unit"]

    if not unit.target or not is_instance_valid(unit.target) or unit.target.is_exhausted():
        return child_node._tick(blackboard, delta)

    return FAILURE
