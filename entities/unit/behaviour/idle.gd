extends BTNode


func _tick(blackboard: Dictionary, _delta: float) -> int:
    blackboard["unit"].state = blackboard["unit"].IDLE

    return SUCCESS
