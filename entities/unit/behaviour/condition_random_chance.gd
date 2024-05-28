extends BTCondition


@export_range(0, 1) var chance := 0.5


func _check_condition(_blackboard: Dictionary) -> bool:
    return randf() < chance
