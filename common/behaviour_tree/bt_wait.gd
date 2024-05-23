class_name Wait
extends BTAction


@export var wait_time := 1.0
## Skip the first wait period.
@export var skip_first := false

@export_group("Random")
@export var random := false
@export var random_range := Vector2(0.0, 1.0)

var current_time: float = 0.0


func _ready():
    if random:
        _randomize()

    if skip_first:
        current_time = wait_time


func _tick(_blackboard: Dictionary, delta: float) -> int:
    current_time += delta

    if current_time >= wait_time:
        current_time = 0.0
        if random:
            _randomize()

        return SUCCESS

    return RUNNING


func _randomize():
    wait_time = randf_range(random_range.x, random_range.y)
