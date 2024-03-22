extends BTLeaf


func tick(blackboard: Dictionary, _delta: float) -> int:
	if not blackboard.has("formation"):
		return FAILURE

	var formation = blackboard["formation"]

	var avg_stamina := 0.0

	var active_units: Array[Unit] = formation.get_active_units()
	for unit: Unit in active_units:
		avg_stamina += unit.golfer_resource.stamina
	
	avg_stamina /= active_units.size()

	# TODO: make threshold a percentage.
	return SUCCESS if avg_stamina < 20 else FAILURE
