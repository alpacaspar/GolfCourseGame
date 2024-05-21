class_name PowerUtility
extends BTUtilityDecorator


@export var factor: float = 1.0


func _get_utility(blackboard : Dictionary) -> float:
    return child_node._get_utility(blackboard) ** factor
