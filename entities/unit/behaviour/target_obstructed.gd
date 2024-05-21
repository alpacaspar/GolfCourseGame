extends BTDecorator


func _tick(blackboard: Dictionary, delta: float):
	var unit: Unit = blackboard["unit"]
	var space_state := unit.get_world_3d().direct_space_state

	var origin := unit.global_position + Vector3.UP * 2
	var end := unit.target.global_position + Vector3.UP
	var query := PhysicsRayQueryParameters3D.create(origin, end)

	var result := space_state.intersect_ray(query)
	
	if result["collider"] == unit.target:
		return FAILURE

	return child_node._tick(blackboard, delta)
