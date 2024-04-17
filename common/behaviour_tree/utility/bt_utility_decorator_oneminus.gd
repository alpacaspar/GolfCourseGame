class_name OneMinusUtility
extends BTUtilityDecorator


func _get_utility(blackboard : Dictionary) -> float:
    return 1.0 - child_node._get_utility(blackboard)