extends BTLeaf


func _tick(blackboard: Dictionary, _delta: float) -> int:
	if not blackboard.has("target_formation"):
		return FAILURE

	var formation: Formation = blackboard["target_formation"]

	# var closest_unit: Unit
	# var closest_distance := INF

	var active_units = formation.get_active_units()
	if active_units.size() == 0:
		return FAILURE

	# for unit: Unit in active_units:
	# 	if unit.is_exhausted():
	# 		continue
		
	# 	var distance = blackboard["controller"].global_position.distance_squared_to(unit.global_position)
	# 	if distance < closest_distance:
	# 		closest_unit = unit
	# 		closest_distance = distance
	
	blackboard["target_unit"] = active_units.pick_random()

	return SUCCESS
