extends BTCondition


@export var blackboard_entry: String = ""


func _check_condition(blackboard: Dictionary) -> bool:
	if not blackboard.has(blackboard_entry) or not blackboard[blackboard_entry]:
		return true
	
	if blackboard[blackboard_entry] is Array:
		return blackboard[blackboard_entry].is_empty()
	
	return false
