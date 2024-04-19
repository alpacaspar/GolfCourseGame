class_name BTNode
extends Node
## Base Node for all behavior tree nodes.


## Override this method to define the behavior of the node.
func tick(_blackboard: Dictionary, _delta: float) -> int:
	return FAILURE


enum {
	## [BTNode] has successfully completed its task.
	SUCCESS,
	## [BTNode] has failed to complete its task.
	FAILURE,
	## [BTNode] is still running its task.
	RUNNING
}
