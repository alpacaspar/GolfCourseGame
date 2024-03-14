class_name BTComposite
extends BTNode
## Abstract class for all child_nodes that can have multiple children.


var child_nodes: Array[BTNode]


func _ready():
	assert(get_child_count() > 0, "BTComposite must have at least one child node.")
	for child_node: Node in get_children():
		if child_node is BTNode:
			child_nodes.append(child_node)
