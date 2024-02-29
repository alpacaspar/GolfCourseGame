class_name SearchState
extends State


@export var body: Golfer
@export var search_target: SearchTarget
@export var preferred_distance: float = 10.0


func _on_enter(_msg := {}):
	BattleManager.on_battle_started.connect(_on_battle_started)


func _on_exit():
	BattleManager.on_battle_started.disconnect(_on_battle_started)


func _on_battle_started():
	body.target = _find_target()

	if body.target == null:
		print("%s of team %s has no target" % [body.golfer.name, body.leader.name])
	else:
		print("%s of team %s has found target %s" % [body.golfer.name, body.leader.name, body.target.golfer.name])

	# TODO: Implement alternative behavior if no target is found.

	fsm_owner.transition_to("AttackState")


func _find_target() -> Golfer:
	var opponents := BattleManager.get_opponents(body.leader)
	var teammates := BattleManager.get_teammates(body.leader)

	match search_target:
		SearchTarget.OPPONENT:
			return _find_free_target(opponents, teammates)
		SearchTarget.TEAMMATE:
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
		if abs(d - preferred_distance) < abs(distance - preferred_distance):
			distance = d
			cached_target = target
		
	return cached_target


enum SearchTarget {
	OPPONENT,
	TEAMMATE,
}
