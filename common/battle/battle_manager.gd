extends Node


signal on_battle_started
signal on_battle_ended(winning_team: TeamResource)

const SPAWN_SPACING = 2.0
const SPAWN_HEIGHT_OFFSET = -0.2

@export_subgroup("Composition")
@export var team_scene: PackedScene

@export_subgroup("Units")
@export var unit_scene: PackedScene
@export var unit_ai_controller: PackedScene
@export var unit_player_controller: PackedScene

var teams: Array[Team] = []


func start_battle(hole: Hole, team1: TeamResource, team2: TeamResource):
	teams.clear()

	_instantiate_team(team1, hole.tee_area)
	_instantiate_team(team2, hole.green)

	await hole.play_intro_sequence()

	on_battle_started.emit()


func end_battle(winning_rival: RivalResource):
	teams.clear()
	on_battle_ended.emit(winning_rival)


func get_opponent_teams(my_team: Team) -> Array[Team]:
	return teams.filter(func(team) -> bool: return team != my_team)


## Returns all units that are not part of the given team.
func get_opponent_units(my_team: Team) -> Array[Unit]:
	var opponents: Array[Unit] = []

	for team in get_opponent_teams(my_team):
		opponents += team.get_active_units()

	return opponents


func get_opponent_units_of_role(my_team: Team, role: Role) -> Array[Unit]:
	return get_opponent_units(my_team).filter(func(unit: Unit) -> bool: return unit.role == role)


func get_units_of_role(my_team: Team, role: Role) -> Array[Unit]:
	return my_team.get_active_units().filter(func(unit: Unit) -> bool: return unit.role == role)


func _instantiate_team(team_resource: TeamResource, origin: Node3D):
	var team_instance := team_scene.instantiate()
	self.add_child(team_instance)
	teams.append(team_instance)

	var spawnpoints := _get_spawnpoints(team_resource.size(), origin, SPAWN_SPACING)

	var unit_instance: Unit
	var controller_instance: Node

	for unit: GolferResource in team_resource.get_composition():
		unit_instance = unit_scene.instantiate()
		team_instance.add_child(unit_instance)
		team_instance.units.append(unit_instance)

		if unit is PlayerRivalResource:
			controller_instance = unit_player_controller.instantiate()
		else:
			controller_instance = unit_ai_controller.instantiate()
		unit_instance.controller = controller_instance
		
		unit_instance.setup(unit, team_instance)
		unit_instance.add_child(controller_instance)

		unit_instance.global_transform.origin = spawnpoints.pop_back()
		unit_instance.global_rotation.y = origin.global_rotation.y

	team_instance.leader = unit_instance


func _get_spawnpoints(amount: int, origin_node: Node3D, spacing: float) -> Array[Vector3]:
	var position := origin_node.global_position
	var direction := origin_node.global_transform.basis.z

	var result: Array[Vector3] = []

	var cross_direction := direction.cross(Vector3.UP)

	var half_amount := ceili(amount * 0.5)
	for i: int in range(-half_amount, half_amount - 1):
		var offset: Vector3 = position + cross_direction * (i * spacing)
		offset.y = get_ground_level(origin_node, offset)
		
		result.append(offset)

	return result


func get_ground_level(origin_node: Node3D, offset: Vector3) -> float:
	var space_state := origin_node.get_world_3d().direct_space_state
	var query := PhysicsRayQueryParameters3D.create(offset, offset + Vector3.DOWN * 100)
	var result := space_state.intersect_ray(query)

	return result["position"].y
