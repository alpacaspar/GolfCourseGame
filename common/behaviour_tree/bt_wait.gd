class_name Wait
extends BTAction


@export var min_wait_time := 1.0
@export var max_wait_time := 2.0

## Skip the first wait period.
@export var skip_first := false

var wait_time := 0.0
var current_time := 0.0


func _ready():
    wait_time = randf_range(min_wait_time, max_wait_time)

    if skip_first:
        current_time = wait_time


func _tick(_blackboard: Dictionary, delta: float) -> int:
    current_time += delta

    if current_time >= wait_time:
        current_time = 0.0
        wait_time = randf_range(min_wait_time, max_wait_time)

        return SUCCESS

    return RUNNING
