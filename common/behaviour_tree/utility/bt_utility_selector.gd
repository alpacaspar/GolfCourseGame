class_name UtilitySelector
extends BTComposite
## Sorts each child by their utility value and ticks them in order until one return SUCCESS. If none succeed, FAILURE is returned.


func _readu():
    super._ready()
    assert(child_nodes.all(func(x: BTNode) -> bool: return x.has_method("get_utility")), "BTUtilitySelector can only have children of type BTUtilityNode")


func tick(blackboard: Dictionary, delta: float) -> int:
    var sort_utility = func(a: BTNode, b: BTNode) -> bool:
        return a.get_utility(blackboard) > b.get_utility(blackboard)

    child_nodes.sort_custom(sort_utility)

    for node: BTNode in child_nodes:
        var status := node.tick(blackboard, delta)
        match status:
            FAILURE:
                continue
            SUCCESS:
                return SUCCESS
            RUNNING:
                return RUNNING
    
    return FAILURE
