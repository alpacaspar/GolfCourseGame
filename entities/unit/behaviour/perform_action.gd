extends BTLeaf


func _tick(blackboard: Dictionary, _delta: float) -> int:
    blackboard["unit"].perform_action()
    
    return SUCCESS
