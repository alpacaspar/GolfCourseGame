extends BTLeaf


func tick(blackboard: Dictionary, _delta: float) -> int:
	if not blackboard.has("target"):
		return SUCCESS
	
	if not is_instance_valid(blackboard["target"]):
		return SUCCESS

	if blackboard["target"].is_exhausted():
		return SUCCESS

	# TODO: If another command is given, return SUCCESS.

	return FAILURE
