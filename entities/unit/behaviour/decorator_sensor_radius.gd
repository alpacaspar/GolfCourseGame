extends BTDecorator


@export var radius := 10.0
@export var team_filter := TeamFilter.ALL
@export var exclude_self := false


func _decorate(blackboard: Dictionary):
    var result: Array[Unit] = []

    var unit: Unit = blackboard["unit"]
    var team: Team = unit.team

    var space_state := unit.get_world_3d().direct_space_state
    var query := _get_query(unit.global_transform)

    var intersections: Array[Dictionary] = space_state.intersect_shape(query)

    for intersection: Dictionary in intersections:
        var colliding_object: Node3D = intersection["collider"]

        if not colliding_object is Unit:
            continue

        var intersected_unit: Unit = colliding_object as Unit
        match team_filter:
            TeamFilter.ALL:
                result.append(intersected_unit)
            TeamFilter.OPPONENT:
                if intersected_unit.team != team:
                    result.append(intersected_unit)
            TeamFilter.ALLY:
                if intersected_unit.team == team:
                    result.append(intersected_unit)

    if exclude_self:
        result.erase(unit)

    blackboard["entities"] = result
    PhysicsServer3D.free_rid(query.shape_rid)


func _get_query(transform: Transform3D) -> PhysicsShapeQueryParameters3D:
    var shape_rid := PhysicsServer3D.sphere_shape_create()
    PhysicsServer3D.shape_set_data(shape_rid, radius)

    var params = PhysicsShapeQueryParameters3D.new()
    params.shape_rid = shape_rid
    params.transform = transform

    return params


enum TeamFilter {
    ALL,
    OPPONENT,
    ALLY
}
