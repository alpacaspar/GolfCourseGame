class_name AlwaysFail
extends BTDecorator
## Always returns a FAILURE status, even if the child node returns SUCCESS.
##
## If the child node is still running, this node will return RUNNING.


func _tick(blackboard: Dictionary, delta: float) -> int:
	return RUNNING if child_node._tick(blackboard, delta) == RUNNING else FAILURE
