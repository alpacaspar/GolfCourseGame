extends BTLeaf


func tick(blackboard: Dictionary, _delta: float) -> int:
	var target_units: Array[Unit] = blackboard["target_formation"].get_active_units()

	if target_units.is_empty():
		return FAILURE

	# Sort units by how many units are targeting them.
	target_units.sort_custom(sort_target_amount)
	
	# pick a random index from the last 3 units.
	var index: int = max((target_units.size() - 1) - randi() % 3, 0)
	var target: Unit = target_units[index]

	if blackboard.has("target") and is_instance_valid(blackboard["target"]):
		blackboard["target"].stop_targeting(blackboard["unit"])

	blackboard["target"] = target
	target.start_targeting(blackboard["unit"])
	
	return SUCCESS


func sort_target_amount(a: Unit, b: Unit) -> int:
	return a.get_target_amount() > b.get_target_amount()
