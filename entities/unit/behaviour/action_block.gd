extends BTAction


@export var min_block_time := 1.0
@export var max_block_time := 5.0

var block_time := 0.0
var current_time := 0.0


func _ready():
    block_time = randf_range(min_block_time, max_block_time)


func _tick(blackboard: Dictionary, _delta: float) -> int:
    var unit: Unit = blackboard["unit"]
    
    if current_time <= 0.0:
        unit.perform_block()

    current_time += _delta

    if current_time >= block_time:
        block_time = randf_range(min_block_time, max_block_time)
        current_time = 0.0
        unit.cancel_block()

        return SUCCESS
    
    return RUNNING
