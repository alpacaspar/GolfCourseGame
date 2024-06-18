extends BTCondition


@export var input_array: StringName = "entities"
@export var group: StringName


func _check_condition(blackboard: Dictionary) -> bool:
	return blackboard[input_array].front().is_in_group(group)
