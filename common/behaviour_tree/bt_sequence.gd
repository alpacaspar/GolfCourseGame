class_name Sequence
extends BTComposite
## Ticks each child node in sequence until one fails or all succeed.


func tick(blackboard: Dictionary, delta: float) -> int:
	for node: BTNode in child_nodes:
		var status = node.tick(blackboard, delta)
		match status:
			FAILURE:
				return FAILURE
			SUCCESS:
				continue
			RUNNING:
				return RUNNING
	
	return SUCCESS
