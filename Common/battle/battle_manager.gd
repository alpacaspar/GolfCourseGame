extends Node


signal on_battle_started
signal on_battle_ended(winningRival: Rival)

var battle_data: Dictionary = {}


func _process(_delta: float):
	if battle_data.size() == 0:
		return
	
	# end the battle as soon as there is only one team standing.
	var standing_teams := battle_data.keys().filter(_is_team_standing)
	if standing_teams.size() == 1:
		end_battle(standing_teams.front())


func start_battle(hole: Hole, player: Rival, rival: Rival):
	battle_data.clear()

	_instantiate_golfers(player, hole.tee_area)
	_instantiate_golfers(rival, hole.green)

	on_battle_started.emit()


func end_battle(winning_rival: Rival):
	# TODO: Perform post battle stuff.
	# TODO: Cleanup battle characters from the scene.

	battle_data.clear()
	on_battle_ended.emit(winning_rival)


func get_opponents(leader: Rival) -> Array:
	var opponents := []

	for rival in battle_data.keys():
		if rival != leader:
			opponents += rival.team

	return opponents


func get_teammates(leader: Rival) -> Array:
	return battle_data[leader]


func _instantiate_golfers(leader: Rival, origin: Node3D):
	var instances := []

	var spawnpoints := _get_spawnpoints(leader.team.size(), origin.global_position, origin.global_basis.z, 2)

	for i in leader.team.size():
		var instance = leader.team[i].role.character_scene.instantiate()
		instance.setup(leader.team[i], leader, spawnpoints[i])
		instances.append(instance)

		add_child(instance)
	
	battle_data[leader] = instances


func _is_team_standing(rival: Rival) -> bool:
	return !rival.team.any(_is_exhausted)


func _is_exhausted(golfer: Golfer) -> bool:
	return golfer.stamina == 0


func _get_spawnpoints(amount: int, offset: Vector3, direction: Vector3, spacing: float) -> Array[Vector3]:
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
