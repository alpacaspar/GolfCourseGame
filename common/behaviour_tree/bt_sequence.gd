class_name Sequence
extends BTComposite
## Ticks each child node in sequence until one fails or all succeed.


var _running_node_index: int = 0


func _tick(blackboard: Dictionary, delta: float) -> int:
    for i: int in range(_running_node_index, child_nodes.size()):
        var status := child_nodes[i]._tick(blackboard, delta)
        match status:
            FAILURE:
                _running_node_index = 0
                return FAILURE
            RUNNING:
                _running_node_index = i
                return RUNNING

    _running_node_index = 0
    return SUCCESS
