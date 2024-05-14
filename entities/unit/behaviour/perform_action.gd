extends BTLeaf


func _tick(blackboard: Dictionary, _delta: float) -> int:
    var unit: Unit = blackboard["unit"]

    unit.perform_action()
    unit.state = unit.ATTACKING
    
    return SUCCESS
