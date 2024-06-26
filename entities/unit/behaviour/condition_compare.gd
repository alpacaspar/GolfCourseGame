extends BTCondition


@export var a: StringName
@export var b: StringName

@export var operation: CompareOperation


func _check_condition(blackboard: Dictionary) -> bool:
	var a_value = blackboard[a]
	var b_value = blackboard[b]

	match operation:
		CompareOperation.LESS_THAN:
			return a_value < b_value
		CompareOperation.LESS_THAN_OR_EQUAL:
			return a_value <= b_value
		CompareOperation.EQUAL:
			return a_value == b_value
		CompareOperation.GREATER_THAN:
			return a_value > b_value
		CompareOperation.GREATER_THAN_OR_EQUAL:
			return a_value >= b_value

	return false


enum CompareOperation {
	LESS_THAN,
	LESS_THAN_OR_EQUAL,
	EQUAL,
	GREATER_THAN,
	GREATER_THAN_OR_EQUAL
}
