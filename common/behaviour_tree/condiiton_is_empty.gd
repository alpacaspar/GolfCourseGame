extends BTCondition


@export var blackboard_key: StringName


func _check_condition(blackboard: Dictionary) -> bool:
	if not blackboard.has(blackboard_key) or not blackboard[blackboard_key]:
		return true
	
	if blackboard[blackboard_key] is Array:
		return blackboard[blackboard_key].is_empty()
	
	return false
