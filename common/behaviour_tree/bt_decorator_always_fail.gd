class_name AlwaysFail
extends BTDecorator
## Always returns a FAILURE status, even if the child node returns SUCCESS.
##
## If the child node is still running, this node will return RUNNING.


func tick(blackboard: Dictionary, delta: float) -> int:
	return RUNNING if child_node.tick(blackboard, delta) == RUNNING else FAILURE
