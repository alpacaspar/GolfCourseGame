extends BTDecorator


func _decorate(blackboard: Dictionary):
	var entities: Array[Node3D] = blackboard["entities"]
	var unit: Unit = blackboard["unit"]

	var best_utility := INF
	var result: Node3D

	for entity: Node3D in entities:
		var utility := unit.global_position.distance_to(entity.global_position)
		
		if entity.is_in_group("ball"):
			utility /= unit.role.max_ball_search_range
		elif entity.is_in_group("unit"):
			utility /= unit.role.max_unit_search_range

		if utility < best_utility:
			best_utility = utility
			result = entity

	if not result:
		return

	entities.clear()
	entities.append(result)
