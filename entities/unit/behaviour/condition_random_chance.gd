extends BTCondition


@export var blackboard_key := &""
@export var override := false
@export_range(0, 1) var chance := 0.5


func _check_condition(_blackboard: Dictionary) -> bool:
	return randf() < (chance if override else _blackboard[blackboard_key])
