extends BTLeaf


func _tick(blackboard: Dictionary, _delta: float) -> int:
	return SUCCESS if blackboard.has("target_formation") && blackboard["target_formation"] else FAILURE