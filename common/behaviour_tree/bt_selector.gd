class_name Selector
extends BTComposite
## Ticks each child node until one returns SUCCESS. If none succeed, FAILURE is returned.


var _running_node_index: int = 0


func _tick(blackboard: Dictionary, delta: float) -> int:
	for i: int in range(_running_node_index, child_nodes.size()):
		var status := child_nodes[i]._tick(blackboard, delta)
		match status:
			SUCCESS:
				_running_node_index = 0
				return SUCCESS
			RUNNING:
				_running_node_index = i
				return RUNNING

	_running_node_index = 0
	return FAILURE
