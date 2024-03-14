class_name BTNode
extends Node
## Base Node for all behavior tree nodes.


## Override this method to define the behavior of the node.
func _tick(_blackboard: Dictionary, _delta: float) -> int:
	return FAILURE


enum {
	SUCCESS, ## [BTNode] has successfully completed its task.
	FAILURE, ## [BTNode] has failed to complete its task.
	RUNNING  ## [BTNode] is still running its task.
}
