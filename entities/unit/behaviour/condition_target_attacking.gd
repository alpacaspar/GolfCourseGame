extends BTCondition


func _check_condition(blackboard: Dictionary) -> bool:
    var target: Unit = blackboard["entities"].front()

    return target.is_attacking
