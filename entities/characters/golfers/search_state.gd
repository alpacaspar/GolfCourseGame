class_name SearchState
extends State


@export var body: Golfer


func _on_enter(_msg := {}):
	BattleManager.on_battle_started.connect(_on_battle_started)


func _on_exit():
	BattleManager.on_battle_started.disconnect(_on_battle_started)


func _on_battle_started():
	var target := _find_target()

	if body.target == null:
		print("%s of team %s has no target" % [body.golfer_resource.name, body.leader_resource.name])
	else:
		print("%s of team %s has found target %s" % [body.golfer_resource.name, body.leader_resource.name, body.target.golfer_resource.name])

	if target:
		body.set_target(target)
		fsm_owner.transition_to("AttackState")

	# TODO: Implement alternative behavior if no target is found.


func _find_target() -> Golfer:
	var opponents := BattleManager.get_opponents(body.leader_resource)
	var teammates := BattleManager.get_teammates(body.leader_resource)

	match body.search_type:
		body.SearchType.OPPONENT:
			return _find_free_target(opponents, teammates)
		body.SearchType.TEAMMATE:
			return _find_free_target(teammates, opponents)
	
	return null


func _find_free_target(target_array: Array, filter_array: Array) -> Golfer:
	if target_array.is_empty():
		return null

	var is_not_already_targeted := func(target_entry: Golfer) -> bool:
		return filter_array.all(func(filter_entry: Golfer) -> bool: return filter_entry.target != target_entry)

	if target_array.any(is_not_already_targeted):
		return _find_closest_at_distance(target_array.filter(is_not_already_targeted))

	return _find_closest_at_distance(target_array)


func _find_closest_at_distance(target_array: Array) -> Golfer:
	var cached_target: Golfer
	var distance := INF

	for target: Golfer in target_array:
		var d := body.global_position.distance_to(target.global_position)

		# Find closest distance to preferred_distance
		if abs(d - body.desired_distance) < abs(distance - body.desired_distance):
			distance = d
			cached_target = target
		
	return cached_target
