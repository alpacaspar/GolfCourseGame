extends BTUtilityLeaf


@export var max_distance := 50.0


func _tick(_blackboard: Dictionary, _delta: float) -> int:
    return SUCCESS


func _get_utility(blackboard: Dictionary) -> float:
    if not blackboard["unit"].target or not is_instance_valid(blackboard["unit"].target):
        return 0.0

    var distance: float = blackboard["unit"].global_position.distance_to(blackboard["unit"].target.global_position)

    return 1 - min(distance, max_distance) / max_distance