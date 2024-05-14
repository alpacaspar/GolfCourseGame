class_name UtilitySelector
extends BTUtilityNode
## Sorts each child by their utility value and ticks them in order until one return SUCCESS. If none succeed, FAILURE is returned.


## The child [BTNode]s of this composite.
var child_nodes: Array[BTUtilityNode]


func _ready():
    assert(get_child_count() > 0, "BTComposite must have at least one child node.")
    for child_node: Node in get_children():
        if child_node is BTUtilityNode:
            child_nodes.append(child_node)


func _tick(blackboard: Dictionary, delta: float) -> int:
    var sort_utility = func(a: BTUtilityNode, b: BTUtilityNode) -> bool:
        return a._get_utility(blackboard) > b._get_utility(blackboard)

    child_nodes.sort_custom(sort_utility)
    
    for node: BTUtilityNode in child_nodes:
        match node._tick(blackboard, delta):
            FAILURE:
                continue
            SUCCESS:
                return SUCCESS
            RUNNING:
                return RUNNING

    return FAILURE
