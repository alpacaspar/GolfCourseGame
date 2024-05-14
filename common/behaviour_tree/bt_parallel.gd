class_name Parallel
extends BTComposite
## Runs child nodes in parallel, 


func _tick(blackboard: Dictionary, delta: float) -> int:
	var result := SUCCESS as int

	for node: BTNode in child_nodes:
		result = node._tick(blackboard, delta)

	return result
