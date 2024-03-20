class_name Selector
extends BTComposite
## Ticks each child node until one returns SUCCESS. If none succeed, FAILURE is returned.


func _tick(blackboard: Dictionary, delta: float) -> int:
	for node: BTNode in child_nodes:
		var status = node._tick(blackboard, delta)
		match status:
			FAILURE:
				continue
			SUCCESS:
				return SUCCESS
			RUNNING:
				return RUNNING
	
	return FAILURE
