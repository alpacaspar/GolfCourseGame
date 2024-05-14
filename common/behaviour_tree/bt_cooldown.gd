class_name Cooldown
extends BTDecorator
## A decorator that starts a cooldown every time the child node returns SUCCESS.


@export var cooldown_time := 1.0

var current_time := 0.0


func _tick(blackboard: Dictionary, delta: float) -> int:
    if current_time > 0.0:
        current_time -= delta
        return FAILURE
    
    var status := child_node._tick(blackboard, delta)

    if status == SUCCESS:
        current_time = cooldown_time
    
    return status
