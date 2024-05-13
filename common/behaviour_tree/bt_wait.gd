class_name BTWait
extends BTLeaf


@export var wait_time := 1.0
## Skip the first wait period.
@export var skip_first := false

var current_time: float = 0.0


func _ready():
    if skip_first:
        current_time = wait_time


func _tick(_blackboard: Dictionary, delta: float) -> int:
    current_time += delta

    if current_time >= wait_time:
        current_time = 0.0
        return SUCCESS

    return RUNNING
