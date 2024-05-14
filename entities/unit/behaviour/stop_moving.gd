extends BTNode


func _tick(blackboard: Dictionary, _delta: float) -> int:
    blackboard["unit"].controller._on_velocity_computed(Vector3.ZERO)

    return SUCCESS