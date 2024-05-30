class_name Succeed
extends BTDecorator
## Consider the child node to have returned a SUCCESS if it is not RUNNING.


func _tick(blackboard: Dictionary, delta: float) -> int:
	return RUNNING if child_node._tick(blackboard, delta) == RUNNING else SUCCESS
