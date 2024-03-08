class_name Formation
extends Node


const MIN_FORMATION_UPDATE_DISTANCE = 10

var team: Team
var role: Role
var units: Array

@onready var formation_update_timer: Timer = $FormationUpdateTimer

var current_target: Vector3


func _ready():
	formation_update_timer.timeout.connect(_on_formation_update_timer_timeout)


func _on_formation_update_timer_timeout():
	var new_target_position: Vector3

	if role.target_type == role.TargetType.OPPONENT:
		new_target_position = _get_average_position(BattleManager.get_opponent_units(team))
	else:
		new_target_position = _get_average_position(team.units)
	
	if new_target_position.distance_squared_to(current_target) > MIN_FORMATION_UPDATE_DISTANCE ** 2:
		current_target = new_target_position
		_update_units(current_target)


func setup(current_team: Team, current_role: Role, current_units: Array):
	team = current_team
	role = current_role
	units = current_units


func _update_units(move_target: Vector3):
	for unit in units:
		unit.set_targets(move_target)
		await get_tree().create_timer(0.1).timeout


func _get_average_position(selection: Array) -> Vector3:
	var average_position := Vector3.ZERO
	for unit in selection:
		average_position += unit.global_position
	
	return average_position / selection.size()
