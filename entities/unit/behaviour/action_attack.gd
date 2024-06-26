extends BTAction


var current_time := 0.0


func _tick(blackboard: Dictionary, _delta: float) -> int:
	var unit: Unit = blackboard["unit"]
	
	if current_time <= 0.0:
		unit.perform_attack()
		unit.is_attacking = true
		unit.controller.navigation_agent.avoidance_enabled = false
	
	current_time += _delta
	
	if current_time >= unit.role.attack_speed:
		current_time = 0.0
		unit.is_attacking = false
		unit.controller.navigation_agent.avoidance_enabled = true
		return SUCCESS

	return RUNNING
