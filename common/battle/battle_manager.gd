extends Node


signal on_battle_setup(teams: Array[Team])
signal on_battle_started
signal on_battle_ended(winning_team: TeamResource)

const SPAWN_SPACING = 2.0
const SPAWN_HEIGHT_OFFSET = -0.2

@export var player_team: PlayerTeamResource

@export_subgroup("Composition")
@export var team_scene: PackedScene

@export_subgroup("Units")
@export var unit_scene: PackedScene
@export var unit_ai_controller: PackedScene
@export var unit_player_controller: PackedScene

var current_battle: Node3D
var teams: Array[Team] = []
var current_hole: Hole

var battle_active := false


func _process(_delta: float):
    if not battle_active:
        return

    for team: Team in teams:
        if team.get_active_units().is_empty():
            # TODO: replace destructor with a proper cleanup function.
            teams.erase(team)
            team.queue_free()

    if teams.size() == 1:
        end_battle(teams.front().leader.golfer_resource)


func start_battle(battle: PackedScene):
	current_battle = battle.instantiate()
	add_child(current_battle)

	var character_factory: Node = load("res://common/character_factory/character_factory.tscn").instantiate()
	add_child(character_factory)

	await _instantiate_team(player_team, current_battle.tee_area, character_factory)
	await _instantiate_team(current_battle.rival_team, current_battle.green, character_factory)

	character_factory.queue_free()

	on_battle_setup.emit(teams)

	await current_battle.play_intro_sequence()

    current_hole = hole
    battle_active = true
    on_battle_started.emit()

    Wwise.register_game_obj(self, get_name())
    Wwise.post_event("play_mus_battle", self)


func end_battle(winning_team: TeamResource):
	battle_active = false
	on_battle_ended.emit(winning_team)

    Wwise.post_event("stop_mus_battle", self)


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


func _instantiate_team(team_resource: TeamResource, origin: Node3D, character_factory: Node):
	var team_instance := team_scene.instantiate()
	team_instance.team_resource = team_resource
	current_battle.add_child(team_instance)
	teams.append(team_instance)

    var spawnpoints := _get_spawnpoints(team_resource.size(), origin, SPAWN_SPACING)

    var unit_instance: Unit
    var controller_instance: Node

	for golfer: GolferResource in team_resource.get_composition():
		unit_instance = unit_scene.instantiate()
		team_instance.add_child(unit_instance)
		team_instance.units.append(unit_instance)

		if golfer.has_meta("is_player"):
			controller_instance = unit_player_controller.instantiate()
		else:
			controller_instance = unit_ai_controller.instantiate()
		unit_instance.controller = controller_instance
		
		await unit_instance.setup(golfer, team_instance, character_factory)
		unit_instance.add_child(controller_instance)

		unit_instance.global_position = spawnpoints.pop_back()
		unit_instance.global_rotation.y = origin.global_rotation.y

    team_instance.leader = unit_instance


func _get_spawnpoints(amount: int, origin_node: Node3D, spacing: float) -> Array[Vector3]:
    var position := origin_node.global_position
    var direction := origin_node.global_transform.basis.z

    var result: Array[Vector3] = []

    var cross_direction := direction.cross(Vector3.UP)
    var start_position: Vector3 = position - cross_direction * (spacing * (amount - 1) / 2.0)

    for i: int in range(amount):
        var offset: Vector3 = start_position + cross_direction * (spacing * i)
        offset.y = get_ground_level(origin_node, offset)
        
        result.append(offset)

    return result


func get_ground_level(origin_node: Node3D, offset: Vector3) -> float:
    var space_state := origin_node.get_world_3d().direct_space_state
    var query := PhysicsRayQueryParameters3D.create(offset, offset + Vector3.DOWN * 100)
    var result := space_state.intersect_ray(query)

    return result["position"].y
