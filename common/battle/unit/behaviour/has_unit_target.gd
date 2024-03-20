extends BTLeaf


func _tick(blackboard: Dictionary, _delta: float) -> int:
	if not blackboard.has("target_unit"):
		return FAILURE

	if not is_instance_valid(blackboard["target_unit"]):
		return FAILURE

	if blackboard["target_unit"].is_exhausted():
		return FAILURE
	
	return SUCCESS
