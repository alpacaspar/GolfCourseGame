extends BTCondition


@export var range_threshold := 10.0


func _check_condition(blackboard: Dictionary) -> bool:
    if not blackboard.has("entities"):
        return false

    if blackboard["entities"].is_empty():
        return false

    return blackboard["unit"].global_position.distance_squared_to(blackboard["entities"].front().global_position) < range_threshold * range_threshold
