class_name BTDecorator
extends BTNode
## Edits the blackboard and ticks child node.


var child_node: BTNode

var child_node_running := false


func _ready():
    assert(get_child_count() > 0, "BTDecorator must have a child node.")
    child_node = get_child(0)


func _tick(blackboard: Dictionary, delta: float) -> int:
    if not child_node_running:
        _decorate(blackboard)

    var status := child_node._tick(blackboard, delta)
    child_node_running = status == RUNNING

    return status


## Override to edit the blackboard before the child node is ticked.
func _decorate(_blackboard: Dictionary):
    pass
