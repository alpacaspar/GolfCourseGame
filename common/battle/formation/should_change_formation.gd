extends BTLeaf


func tick(blackboard: Dictionary, _delta: float) -> int:
	if not blackboard.has("target_formation"):
		return SUCCESS
	
	if blackboard["target_formation"].get_active_units().is_empty():
		return SUCCESS

	# TODO: If a command is given to this formation, return success.

	return FAILURE
