extends BTDecorator


@export var range_threshold := 6.0


func _tick(blackboard: Dictionary, delta: float) -> int:
    var unit: Unit = blackboard["unit"]

    var opponents: Array[Unit] = BattleManager.get_opponent_units(unit.team)

    for opponent: Unit in opponents:
        if unit.global_position.distance_squared_to(opponent.global_position) <= range_threshold ** 2:
            return child_node._tick(blackboard, delta)

    return FAILURE
