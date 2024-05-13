class_name Parallel
extends BTComposite
## Similar to [Sequence], but will continue to the next child node even if the current one is still running.


func _tick(blackboard: Dictionary, delta: float) -> int:
	var result := FAILURE

	for node: BTNode in child_nodes:
		var status := node._tick(blackboard, delta)
		match status:
			FAILURE:
				return FAILURE
			SUCCESS:
				result = SUCCESS
				continue
			RUNNING:
				result = RUNNING
				continue

	return result
