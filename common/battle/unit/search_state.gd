extends State


@export var ai_controller: Node3D


func _on_enter(_msg := {}):
	_perform_search()


func _on_exit():
	pass


func _perform_search():
	# Safeguard to avoid searching before all nodes are ready.
	await get_tree().physics_frame

	#var target = _find_target()

	# if target:
	# 	print("%s of team %s has found target %s" % [ai_controller.body.golfer_resource.name, ai_controller.body.leader_resource.name, target.golfer_resource.name])
	# else:
	# 	print("%s of team %s has no target" % [ai_controller.body.golfer_resource.name, ai_controller.body.leader_resource.name])

	# if target:
	# 	fsm_owner.transition_to("GotoState", { "target": target })


func _find_target():
	pass
	#var opponents := BattleManager.get_opponents(ai_controller.body.leader_resource)
	#var teammates := BattleManager.get_teammates(ai_controller.body.leader_resource)

	#return _find_random_target(opponents)

	# match body.search_type:
	# 	body.SearchType.OPPONENT:
	# 		return _find_free_target(opponents, teammates)
	# 	body.SearchType.TEAMMATE:
	# 		return _find_free_target(teammates)
	#
	# return null


func _find_random_target(target_array: Array) -> Unit:
	if target_array.is_empty():
		return null

	return target_array.pick_random()


func _find_free_target(target_array: Array, filter_array := []) -> Unit:
	if target_array.is_empty():
		return null

	var is_not_already_targeted := func(target_entry: Unit) -> bool:
		return filter_array.all(func(filter_entry: Unit) -> bool: return filter_entry.global_position.distance_squared_to(target_entry.global_position) > 2 * 2)

	if !filter_array.is_empty() && target_array.any(is_not_already_targeted):
		return _find_closest_at_distance(target_array.filter(is_not_already_targeted))

	return _find_closest_at_distance(target_array)


func _find_closest_at_distance(target_array: Array) -> Unit:
	var cached_target: Unit
	var distance := INF

	for target: Unit in target_array:
		var d := ai_controller.global_position.distance_to(target.global_position)

		if abs(d - ai_controller.desired_distance) < abs(distance - ai_controller.desired_distance):
			distance = d
			cached_target = target
		
	return cached_target
