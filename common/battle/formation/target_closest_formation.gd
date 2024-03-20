extends BTLeaf


func _tick(blackboard: Dictionary, _delta: float) -> int:
	if not blackboard.has("formation"):
		return FAILURE

	var opponent_teams = BattleManager.get_opponent_teams(blackboard["formation"].team)
	var opponent_formations: Array[Formation] = []

	for team: Team in opponent_teams:
		opponent_formations += team.formations
		
	if opponent_formations.is_empty():
		return FAILURE
	
	# get the closest formation
	var closest_formation: Formation
	# var closest_distance := INF

	# for formation: Formation in opponent_formations:
	# 	var distance = blackboard["formation"].position.distance_squared_to(formation.position)
	# 	if distance < closest_distance:
	# 		closest_distance = distance
	# 		closest_formation = formation

	closest_formation = opponent_formations.pick_random()

	blackboard["target_position"] = closest_formation.get_center_position()
	blackboard["target_formation"] = closest_formation

	return SUCCESS
