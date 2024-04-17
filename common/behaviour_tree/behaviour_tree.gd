class_name BehaviourTree
extends BTNode
## Hierarchical structure for controlling the flow of fixed behaviour, often used for AI.

## Dictionary for sharing data between nodes in the tree.
var blackboard: Dictionary = {}
var child_node: BTNode


func _ready():
	assert(get_child_count() > 0, "BehaviourTree must have a child node.")
	child_node = get_child(0)


## This function should only be called by other [BTNodes]. For external use, use [process_tree].
func _tick(_blackboard: Dictionary, delta: float) -> int:
	return child_node._tick(_blackboard, delta)


## Tick the tree, this function should be used if the Behaviour Tree is not an internal Behaviour Tree
func process_tree(delta: float):
	if child_node:
		child_node._tick(blackboard, delta)
