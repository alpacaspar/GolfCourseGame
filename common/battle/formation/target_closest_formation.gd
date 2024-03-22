extends BTLeaf


func tick(blackboard: Dictionary, _delta: float) -> int:
	if not blackboard.has("formation"):
		return FAILURE

	var opponent_teams = BattleManager.get_opponent_teams(blackboard["formation"].team)
	var opponent_formations: Array[Formation] = []

	for team: Team in opponent_teams:
		opponent_formations += team.formations
		
	if opponent_formations.is_empty():
		return FAILURE
	
	var target_formation: Formation

	# If any of the opponent formations are targeting the current formation, target that formation back.
	for formation: Formation in opponent_formations:
		if formation.target_formation == blackboard["formation"]:
			target_formation = formation

	# If no target has been found yet, just pick a random formation.
	if not target_formation:
		target_formation = opponent_formations.pick_random()

	blackboard["target_formation"] = target_formation

	for unit: Unit in blackboard["formation"].get_active_units():
		unit.give_command(blackboard["target_formation"])

	return SUCCESS
