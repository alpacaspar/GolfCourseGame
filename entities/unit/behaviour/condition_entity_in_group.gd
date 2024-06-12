extends BTCondition


@export var group: StringName


func _check_condition(blackboard: Dictionary) -> bool:
	return blackboard["entities"].front().is_in_group(group)
