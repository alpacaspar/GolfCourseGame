extends BTDecorator


@export var blackboard_key: StringName
@export var output_key: StringName

@export var square_distance := false


func _decorate(blackboard: Dictionary):
	var unit: Unit = blackboard["unit"]
	var target: Node3D
	
	if blackboard[blackboard_key] is Array:
		target = blackboard[blackboard_key].front()
	else:
		target = blackboard[blackboard_key]
	
	if square_distance:
		blackboard[output_key] = unit.global_position.distance_squared_to(target.global_position)
	else:
		blackboard[output_key] = unit.global_position.distance_to(target.global_position)
