class_name BehaviourTree
extends BTNode
## Hierarchical structure for controlling the flow of fixed behaviour, often used for AI.

## Dictionary for sharing data between nodes in the tree.
var blackboard: Dictionary = {}
var child_node: BTNode


func _ready():
	assert(get_child_count() > 0, "BehaviourTree must have a child node.")
	child_node = get_child(0)


func tick_tree(delta: float):
	if child_node:
		child_node._tick(blackboard, delta)
