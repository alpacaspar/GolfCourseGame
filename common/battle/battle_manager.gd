extends Node


signal on_battle_started
signal on_battle_ended(winningRival: RivalResource)

const UNIT_SCENE: PackedScene = preload("res://entities/unit/unit.tscn")
const UNIT_AI_CONTROLLER: PackedScene = preload("res://entities/unit/unit_ai_controller.tscn")
const UNIT_PLAYER_CONTROLLER: PackedScene = preload("res://entities/unit/unit_player_controller.tscn")

## A dictionary containing all instances in an [Array] currently in battle per [RivalResource].
var team_instances := {}

#region Callables
var _is_team_standing := func(rival: RivalResource) -> bool:
	return !team_instances[rival].any(_is_instance_exhausted)

var _is_instance_not_exhausted := func(instance: Unit) -> bool:
	return !instance.is_exhausted()

var _is_instance_exhausted := func(instance: Unit) -> bool:
	return instance.is_exhausted()
#endregion


func _process(_delta: float):
	if team_instances.is_empty():
		return
	
	# end the battle as soon as there is only one team standing.
	var standing_teams := team_instances.keys().filter(_is_team_standing)
	if standing_teams.size() == 1:
		end_battle(standing_teams.front())


func start_battle(hole: Hole, player: RivalResource, rival: RivalResource):
	team_instances.clear()

	_instantiate_golfers(player, hole.tee_area)
	_instantiate_golfers(rival, hole.green)

	on_battle_started.emit()


func end_battle(winning_rival: RivalResource):
	# TODO: Perform post battle stuff.
	# TODO: Cleanup battle characters from the scene.

	team_instances.clear()
	on_battle_ended.emit(winning_rival)


## Returns [Array] containing all instances of opponents that are not exhausted.
func get_opponents(leader: RivalResource) -> Array:
	var opponents := []

	for rival in team_instances.keys():
		if rival != leader:
			opponents += team_instances[rival].filter(_is_instance_not_exhausted)

	return opponents


## Returns [Array] containing all instances of teammates that are not exhausted.
func get_teammates(leader: RivalResource) -> Array:
	return team_instances[leader].filter(_is_instance_not_exhausted)


func _instantiate_golfers(leader: RivalResource, origin: Node3D):
	var instances := []

	var spawnpoints := _get_triangular_points(leader.team.size(), origin.global_position, origin.global_basis.z, 5)

	for i in leader.team.size():
		var instance = UNIT_SCENE.instantiate()
		instance.transform.origin = spawnpoints[i]

		if leader.team[i] is PlayerRivalResource:
			instance.add_child(UNIT_PLAYER_CONTROLLER.instantiate())
		else:
			instance.add_child(UNIT_AI_CONTROLLER.instantiate())
		
		instance.setup(leader.team[i], leader)
		
		instances.append(instance)

		add_child(instance)
	
	team_instances[leader] = instances


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
