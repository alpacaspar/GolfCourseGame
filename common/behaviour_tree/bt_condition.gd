class_name BTCondition
extends BTNode
## Ticks the child node if the condition is met.


@export var invert := false

var child_node: BTNode

var child_node_running := false


func _ready():
	assert(get_child_count() > 0, "BTDecorator must have a child node.")
	child_node = get_child(0)


func _tick(blackboard: Dictionary, delta: float) -> int:
	if child_node_running or _check_condition(blackboard) != invert:
		var status := child_node._tick(blackboard, delta)
		child_node_running = status == RUNNING

		return status

	return FAILURE


## Override to check if the child node should be ticked.
func _check_condition(_blackboard: Dictionary) -> bool:
	return true
