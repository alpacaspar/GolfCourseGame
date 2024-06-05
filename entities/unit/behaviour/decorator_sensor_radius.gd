extends BTDecorator


@export var radius := 10.0
@export var team_filter := EntityFilter.ALL
@export var exclude_self := false
@export_flags_3d_physics var sensor_collision_mask := 1


func _decorate(blackboard: Dictionary):
    var result: Array[Node3D] = []

    var unit: Unit = blackboard["unit"]
    var team: Team = unit.team

    var space_state := unit.get_world_3d().direct_space_state
    var query := _get_query(unit.global_transform)

    var intersections: Array[Dictionary] = space_state.intersect_shape(query)

    for intersection: Dictionary in intersections:
        var intersected_entity: Node3D = intersection["collider"]
        match team_filter:
            EntityFilter.ALL:
                result.append(intersected_entity)
            EntityFilter.OPPONENT:
                if intersected_entity.is_in_group("unit"):
                    if intersected_entity.team != team:
                        result.append(intersected_entity)
            EntityFilter.ALLY:
                if intersected_entity.is_in_group("unit"):
                    if intersected_entity.team == team:
                        result.append(intersected_entity)
            EntityFilter.BALL:
                if intersected_entity.is_in_group("ball"):
                    result.append(intersected_entity)

    if exclude_self:
        result.erase(unit)

    blackboard["entities"] = result
    PhysicsServer3D.free_rid(query.shape_rid)


func _get_query(transform: Transform3D) -> PhysicsShapeQueryParameters3D:
    var shape_rid := PhysicsServer3D.sphere_shape_create()
    PhysicsServer3D.shape_set_data(shape_rid, radius)

    var params := PhysicsShapeQueryParameters3D.new()
    params.shape_rid = shape_rid
    params.transform = transform
    params.collision_mask = sensor_collision_mask

    return params


enum EntityFilter {
    ALL,
    OPPONENT,
    ALLY,
    BALL
}
