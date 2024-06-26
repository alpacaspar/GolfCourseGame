extends BTAction


const AIM_ROTATION_DELTA = 10.0


@export var input_array: StringName = "entities"


func _tick(blackboard: Dictionary, delta: float) -> int:
	var unit: Unit = blackboard["unit"]
	var navigation_agent: NavigationAgent3D = unit.controller.navigation_agent

	if not blackboard.has(input_array):
		return FAILURE

	if blackboard[input_array].is_empty():
		return FAILURE

	unit.controller.set_movement_target(blackboard[input_array].front().global_position)
	
	if navigation_agent.is_navigation_finished():
		unit.controller.set_velocity(Vector3.ZERO)
		return SUCCESS

	var next_path_position: Vector3 = navigation_agent.get_next_path_position()
	var new_velocity: Vector3 = unit.global_position.direction_to(next_path_position) * unit.move_speed

	unit.controller.set_velocity(new_velocity)

	var real_velocity := unit.get_real_velocity()

	var angle := atan2(real_velocity.x, real_velocity.z)
	unit.controller.global_rotation.y = rotate_toward(unit.controller.global_rotation.y, angle, AIM_ROTATION_DELTA * delta)

	return RUNNING
