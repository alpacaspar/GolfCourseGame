extends BTLeaf


func _tick(blackboard: Dictionary, _delta: float) -> int:
	var formation: Formation = blackboard["target_formation"]

	var closest_unit: Unit
	var closest_distance := INF

	for unit: Unit in formation.units:
		if unit.is_exhausted():
			continue
		
		var distance = blackboard["controller"].global_position.distance_squared_to(unit.global_position)
		if distance < closest_distance:
			closest_unit = unit
			closest_distance = distance
	
	blackboard["target_unit"] = closest_unit

	return SUCCESS