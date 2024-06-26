extends BTDecorator


@export var input_array: StringName = "entities"


func _decorate(blackboard: Dictionary):
	var result: Unit

	for unit: Unit in blackboard[input_array]:
		if unit.is_attacking:
			result = unit
			break
	
		blackboard[input_array].clear()
		blackboard[input_array].append(result)
