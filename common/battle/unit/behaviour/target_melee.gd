extends BTUtilityLeaf


@export var target_role: Role
@export var max_distance := 50.0


func _tick(blackboard: Dictionary, _delta: float) -> int:
    blackboard["target"] = _get_closest_target(blackboard["unit"])

    return SUCCESS if blackboard["target"] else FAILURE


func _get_utility(blackboard: Dictionary) -> float:
    var current_unit: Unit = blackboard["unit"]
    var target: Unit = _get_closest_target(current_unit)

    if not target:
        return 0.0

    var distance: float = current_unit.global_position.distance_to(target.global_position)
    return 1 - min(distance, max_distance) / max_distance


func _get_closest_target(current_unit: Unit) -> Unit:
    var closest_distance := INF
    var target: Unit

    for unit: Unit in BattleManager.get_opponent_units_of_role(current_unit.team, target_role):
        var distance_squared: float = current_unit.global_position.distance_squared_to(unit.global_position)
        if distance_squared < closest_distance:
            target = unit
            closest_distance = distance_squared

    return target
