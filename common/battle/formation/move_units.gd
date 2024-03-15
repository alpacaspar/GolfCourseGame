extends BTLeaf


var instructing_units: bool = false


func _tick(blackboard: Dictionary, _delta: float) -> int:
	if not blackboard.has("formation"):
		return FAILURE
	
	if not instructing_units:
		_instruct_units(blackboard, _delta)
	
	return RUNNING if instructing_units else SUCCESS


func _instruct_units(blackboard: Dictionary, _delta: float):
	instructing_units = true

	var formation: Formation = blackboard["formation"]

	var target_position: Vector3 = blackboard["target_position"]
	var target_formation: Formation = blackboard["target_formation"]

	for unit: Unit in formation.units:
		unit.give_instructions(target_position, target_formation)
		await get_tree().create_timer(0.1).timeout
	
	instructing_units = false