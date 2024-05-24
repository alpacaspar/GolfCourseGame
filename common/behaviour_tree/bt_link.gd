class_name Link
extends BTNode
## [BTNode] that executes the linked node.


## The node to tick.
@export var link: BTNode


func _ready():
    assert(link is BTNode, "Link is not set for node " + str(self))


func _tick(blackboard: Dictionary, delta: float) -> int:
    return link._tick(blackboard, delta)
