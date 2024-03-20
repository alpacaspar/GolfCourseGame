class_name BTTimer
extends BTLeaf


@export var wait_time: float = 1.0

var current_time: float = 0.0


func _tick(_blackboard: Dictionary, delta: float) -> int:
	current_time += delta

	if current_time >= wait_time:
		current_time = 0.0
		return SUCCESS
	
	return RUNNING
