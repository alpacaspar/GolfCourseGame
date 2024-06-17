extends BTDecorator


@export var blackboard_value: StringName
@export var override := false
@export var radius := 10.0
@export_flags("All:1", "Teammates:2", "Opponents:4", "Ball:8") var sensor_filter := 0
@export var exclude_self := false
@export_flags_3d_physics var sensor_collision_mask := 1


func _decorate(blackboard: Dictionary):
	var result: Array[Node3D] = []

	var unit: Unit = blackboard["unit"]
	var team: Team = unit.team

	var space_state := unit.get_world_3d().direct_space_state
	var query := _get_query(unit, radius if override else blackboard[blackboard_value])

	var intersections: Array[Dictionary] = space_state.intersect_shape(query)

	for intersection: Dictionary in intersections:
		var intersected_entity: Node3D = intersection["collider"]
		if sensor_filter & 1:
			result.append(intersected_entity)
		elif intersected_entity.is_in_group("unit"):
			if sensor_filter & 2 and intersected_entity.team == team:
				result.append(intersected_entity)
			elif sensor_filter & 4 and intersected_entity.team != team:
				result.append(intersected_entity)
		elif sensor_filter & 8 and intersected_entity.is_in_group("ball"):
			result.append(intersected_entity)

	blackboard["entities"] = result
	PhysicsServer3D.free_rid(query.shape_rid)


func _get_query(requesting_node: PhysicsBody3D, query_radius: float) -> PhysicsShapeQueryParameters3D:
	var shape_rid := PhysicsServer3D.sphere_shape_create()
	PhysicsServer3D.shape_set_data(shape_rid, query_radius)

	var params := PhysicsShapeQueryParameters3D.new()
	params.shape_rid = shape_rid
	params.transform = requesting_node.global_transform
	params.collision_mask = sensor_collision_mask

	if exclude_self:
		params.exclude = [requesting_node.get_rid()]

	return params
