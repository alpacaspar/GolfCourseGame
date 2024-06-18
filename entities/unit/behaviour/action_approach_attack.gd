extends BTAction


const AIM_ROTATION_DELTA = 10.0


@export var input_array: StringName = "entities"
@export var opponent_array: StringName = "entities"


func _tick(blackboard: Dictionary, delta: float) -> int:
	var unit: Unit = blackboard["unit"]
	var navigation_agent: NavigationAgent3D = unit.controller.navigation_agent

	var target: Node3D = blackboard[input_array].front()
	var opponent: Node3D = blackboard[opponent_array].front()

	var direction_to_target: Vector3 = target.global_position.direction_to(Vector3(opponent.global_position.x, target.global_position.y, opponent.global_position.z))

	unit.controller.set_movement_target(target.global_position - direction_to_target * blackboard["attack_range"])

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
