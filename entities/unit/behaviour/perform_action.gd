extends BTLeaf


var swing_cooldown_time := 4.0
var current_time := 0.0


func _tick(blackboard: Dictionary, delta: float) -> int:
	if current_time == 0:
		blackboard["unit"].perform_action()
		blackboard["performing_action"] = true
	
	current_time += delta
	if current_time >= swing_cooldown_time:
		current_time = 0
		blackboard["performing_action"] = false
		return SUCCESS
	else:
		return RUNNING
