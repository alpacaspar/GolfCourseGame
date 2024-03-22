extends BTLeaf


func tick(blackboard: Dictionary, _delta: float) -> int:
	if not blackboard.has("target_formation"):
		return FAILURE
	
	if blackboard["target_formation"] == null:
		return FAILURE

	return SUCCESS