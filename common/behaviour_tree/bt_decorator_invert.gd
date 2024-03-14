class_name Invert
extends BTDecorator
## Inverts the status of a child node.


func _tick(blackboard: Dictionary, delta: float) -> int:
	var status = child_node._tick(blackboard, delta)
	match status:
		FAILURE:
			return SUCCESS
		SUCCESS:
			return FAILURE

	return status
