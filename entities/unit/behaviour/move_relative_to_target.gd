extends BTAction


## Move in angle relative to the direction towards the target.
@export_range(0, 360) var angle: float = 0.0
@export var duration := 0.1

var current_time := 0.0


func _tick(blackboard: Dictionary, delta: float) -> int:
	var unit: Unit = blackboard["unit"]
	var controller: Node = unit.controller
	var target: Unit = unit.target

	if current_time >= duration:
		current_time = 0.0
		return SUCCESS

	current_time += delta

	var direction_delta: Vector3 = Vector3(target.global_position.x, unit.global_position.y, target.global_position.z) - unit.global_position
	var new_velocity := direction_delta.rotated(Vector3.UP, deg_to_rad(angle))

	controller._on_velocity_computed(new_velocity)
	
	return RUNNING
