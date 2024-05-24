extends BTUtilityLeaf


@export var target_role: Role
@export var max_distance := 100.0
@export var target_team := TargetTeam.OPPONENT


func _tick(blackboard: Dictionary, _delta: float) -> int:
    blackboard["unit"].target = _get_closest_target(blackboard["unit"])

    return SUCCESS if blackboard["unit"].target else FAILURE


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

    var selection: Array[Unit]
    match target_team:
        TargetTeam.SELF:
            selection = BattleManager.get_units_of_role(current_unit.team, target_role)
        TargetTeam.OPPONENT:
            selection = BattleManager.get_opponent_units_of_role(current_unit.team, target_role)

    for unit: Unit in selection:
        if unit == current_unit:
            continue
        var distance_squared: float = current_unit.global_position.distance_squared_to(unit.global_position)
        if distance_squared < closest_distance:
            target = unit
            closest_distance = distance_squared

    return target


enum TargetTeam { SELF, OPPONENT }
