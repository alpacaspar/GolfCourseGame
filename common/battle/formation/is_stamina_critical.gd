extends BTLeaf


func _tick(blackboard: Dictionary, _delta: float) -> int:
	if not blackboard.has("formation"):
		return FAILURE

	var formation = blackboard["formation"]

	var avg_stamina := 0.0

	for unit: Unit in formation.units:
		avg_stamina += unit.golfer_resource.stamina
	
	avg_stamina /= formation.units.size()

	# TODO: make threshold a percentage.
	return SUCCESS if avg_stamina < 20 else FAILURE