class_name Selector
extends BTComposite
## Ticks each child node until one returns SUCCESS. If none succeed, FAILURE is returned.


func _tick(blackboard: Dictionary, delta: float) -> int:
	var any_child_running := false

	for node: BTNode in child_nodes:
		var status = node._tick(blackboard, delta)
		match status:
			FAILURE:
				continue
			SUCCESS:
				return SUCCESS
			RUNNING:
				any_child_running = true
				continue
	
	return RUNNING if any_child_running else FAILURE
