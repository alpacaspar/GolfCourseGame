extends Node


signal on_battle_started
signal on_battle_ended(winning_team: TeamResource)

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

    var spawnpoints := _get_spawnpoints(team_resource.size(), origin.global_position, origin.global_transform.basis.z, 10.0)

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

    team_instance.leader = unit_instance


## Returns an array of points in a triangular pattern (bowling pin formation).
func _get_spawnpoints(amount: int, offset: Vector3, direction: Vector3, spacing: float) -> Array[Vector3]:
    var result: Array[Vector3] = []

    var half_amount := ceili(amount * 0.5)

    var cross_direction := direction.cross(Vector3.UP)

    for i: int in range(-half_amount, half_amount - 1):
        result.append(offset + cross_direction * (i * spacing))

    return result