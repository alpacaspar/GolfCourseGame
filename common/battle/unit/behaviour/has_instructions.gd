extends BTLeaf


func _tick(blackboard: Dictionary, _delta: float) -> int:
	return SUCCESS if blackboard.has("target_position") else FAILURE