extends BTLeaf


var swing_cooldown_time := 4.0
var current_time := 0.0


func _tick(blackboard: Dictionary, delta: float) -> int:
    var unit: Unit = blackboard["unit"]

    if current_time == 0:
        unit.perform_action()
        unit.state = unit.ATTACKING

    current_time += delta
    if current_time >= swing_cooldown_time:
        current_time = 0
        unit.state = unit.IDLE
        return SUCCESS
    
    return RUNNING
