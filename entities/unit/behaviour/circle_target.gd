extends BTLeaf


@export var preferred_range := 4.0
@export var move_speed := 4.0

var circle_direction_positive := true


func _tick(blackboard: Dictionary, _delta: float) -> int:
	var unit: Unit = blackboard["unit"]
	var controller: Node = unit.controller
	var navigation_agent: NavigationAgent3D = controller.navigation_agent

	var target_position_horizontal: Vector3 = unit.target.global_position
	target_position_horizontal.y = unit.global_position.y

	var target_direction := unit.global_position.direction_to(target_position_horizontal)
	var target_cross := target_direction.cross(Vector3.UP)
	var target_distance := unit.global_position.distance_to(target_position_horizontal)
	var distance_weight = (target_distance - preferred_range) / preferred_range
	
	target_cross *= 1 if circle_direction_positive else -1
	
	var new_velocity = target_direction * distance_weight + target_cross * (1 - distance_weight)
	new_velocity *= move_speed

	if navigation_agent.avoidance_enabled:
		navigation_agent.set_velocity(new_velocity)
	else:
		controller._on_velocity_computed(new_velocity)

	return SUCCESS


func _on_timer_timeout():
	circle_direction_positive = !circle_direction_positive
