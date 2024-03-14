class_name BTDecorator
extends BTNode
## Abstract class for modifying the outcome of a [BTNode].


var child_node: BTNode


func _ready():
	assert(get_child_count() > 0, "BTDecorator must have a child node.")
	child_node = get_child(0)
