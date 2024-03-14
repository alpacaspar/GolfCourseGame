class_name Sequence
extends BTComposite
## Ticks each child node in sequence until one fails or all succeed.


func _tick(blackboard: Dictionary, delta: float) -> int:
	var any_child_running := false

	for node: BTNode in child_nodes:
		var status = node._tick(blackboard, delta)
		match status:
			FAILURE:
				return FAILURE
			SUCCESS:
				continue
			RUNNING:
				any_child_running = true
				continue
	
	return RUNNING if any_child_running else SUCCESS
