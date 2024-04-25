extends Node


signal on_battle_started
signal on_battle_ended(winning_team: TeamResource)

@export_subgroup("Composition")
@export var team_scene: PackedScene

@export_subgroup("Units")
@export var unit_ai_controller: PackedScene
@export var unit_player_controller: PackedScene

var teams: Array[Team] = []


func _process(_delta: float):
	if teams.is_empty():
		return


func start_battle(hole: Hole, team1: TeamResource, team2: TeamResource):
	teams.clear()

	_instantiate_team(team1, hole.tee_area)
	_instantiate_team(team2, hole.green)

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


func _instantiate_team(team_resource: TeamResource, origin: Node3D):
	var team_instance := team_scene.instantiate()
	self.add_child(team_instance)
	teams.append(team_instance)

	var spawnpoints := _get_triangular_points(team_resource.size(), origin.global_position, origin.global_transform.basis.z, 4.0)

	var unit_instance: Unit
	var controller_instance: Node

	for unit: GolferResource in team_resource.get_composition():
		unit_instance = unit.role.unit_scene.instantiate()
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

	team_instance.leader = unit_instance


## Returns an array of points in a triangular pattern (bowling pin formation).
func _get_triangular_points(amount: int, offset: Vector3, direction: Vector3, spacing: float) -> Array[Vector3]:
	var rows: int = ceil((sqrt(8 * amount + 1) - 1) * 0.5)

	var vectors: Array[Vector3] = []

	var forward = direction.normalized()
	var right = direction.cross(Vector3.UP).normalized()
	var up = right.cross(direction).normalized()

	for row in range(1, rows + 1):
		for point in row:
			if vectors.size() >= amount:
				return vectors
			
			var x = (point - row * 0.5 + 0.5) * spacing
			var z = -row * spacing

			var local_pos = Vector3(x, 0, z)
			var world_pos = right * local_pos.x + up * local_pos.y + forward * local_pos.z

			vectors.append(world_pos + offset)

	return vectors
