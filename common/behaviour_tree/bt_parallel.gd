class_name Parallel
extends BTComposite
## Similar to the [Sequence] node, but runs all of its children every tick. The last node that was ticked is the node's result.


func _tick(blackboard: Dictionary, delta: float) -> int:
	var result := SUCCESS as int

	for node: BTNode in child_nodes:
		result = node._tick(blackboard, delta)

		if result == FAILURE:
			return FAILURE

	return result
