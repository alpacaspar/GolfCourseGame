class_name SearchState
extends State


@export var body: GolferBody
@export var search_target: SearchTarget

var preferred_distance: float = 10.0


func _on_enter(fsm: FSM, _msg := {}):
	var target = _find_target()

	fsm.transition_to("AttackState", {"target": target})


func _on_input(_event: InputEvent, _fsm: FSM):
	pass


func _on_unhandled_input(_event: InputEvent, _fsm: FSM):
	pass


func _on_process(_delta: float, _fsm: FSM):
	pass


func _on_physics_process(_delta: float, _fsm: FSM):
	pass


func _on_exit(_msg := {}):
	pass


func _find_target() -> Node3D:
	var targets: Array
	match search_target:
		SearchTarget.OPPONENT:
			targets = BattleManager.get_opponents(body.leader)
		SearchTarget.TEAMMATE:
			targets = BattleManager.get_teammates(body.leader)

	if targets.is_empty():
		return null

	var cached_target: Node3D
	var distance := INF

	for target: Node3D in targets:
		var d := body.global_position.distance_to(target.global_position)

		# Find closest distance to preferred_distance
		if abs(d - preferred_distance) < abs(distance - preferred_distance):
			distance = d
			cached_target = target
		
	return cached_target


enum SearchTarget {
	OPPONENT,
	TEAMMATE
}