class_name Repeat
extends BTDecorator
## Execute child node until returning FAILURE.


func _tick(blackboard: Dictionary, delta: float):
	return FAILURE if child_node._tick(blackboard, delta) == FAILURE else RUNNING 
