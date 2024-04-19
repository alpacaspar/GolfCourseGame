class_name Invert
extends BTDecorator
## Inverts the status of a child node.


func tick(blackboard: Dictionary, delta: float) -> int:
	var status = child_node.tick(blackboard, delta)
	match status:
		FAILURE:
			return SUCCESS
		SUCCESS:
			return FAILURE

	return status
