class_name BTUtilityDecorator
extends BTUtilityNode
## Abstract class for creating decorators for utility nodes.


var child_node: BTUtilityNode


func _ready():
    assert(get_child_count() > 0, "BTDecorator must have a child node.")
    child_node = get_child(0)


func _tick(blackboard: Dictionary, delta: float) -> int:
    return child_node._tick(blackboard, delta)


func _get_utility(blackboard: Dictionary) -> float:
    return child_node._get_utility(blackboard)