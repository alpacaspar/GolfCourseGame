extends Node


signal on_battle_started
signal on_battle_ended(winning_team: TeamResource)

@export_subgroup("Composition")
@export var team_scene: PackedScene
@export var formation_scene: PackedScene

@export_subgroup("Units")
@export var unit_scene: PackedScene
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


func _instantiate_team(team_resource: TeamResource, origin: Node3D):
	var commander: Node3D

	var team := team_scene.instantiate()
	add_child(team)

	var spawnpoints := _get_triangular_points(team_resource.size, origin.global_position, origin.global_basis.z, 5)

	for role: Role in team_resource.formations.keys():
		var formation := formation_scene.instantiate()
		team.add_child(formation)
		
		var instances := []
		
		for member: GolferResource in team_resource.formations[role]:
			var unit := unit_scene.instantiate()

			if member is PlayerRivalResource:
				unit.add_child(unit_player_controller.instantiate())
			else:
				unit.add_child(unit_ai_controller.instantiate())
			
			unit.setup(member)
			formation.add_child(unit)

			unit.global_position = spawnpoints.pop_front()

			if member is RivalResource:
				commander = unit

			instances.append(unit)
		
		formation.setup(team, instances)
	
	team.setup(commander)
	teams.append(team)


## Return an array of points in a triangular pattern (bowling pin formation).
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
