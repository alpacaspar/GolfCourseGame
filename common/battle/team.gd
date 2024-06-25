class_name Team
extends Node


var team_resource: TeamResource

var leader: Unit
var units: Array[Unit]


func size() -> int:
	return units.size() + 1


func get_active_units() -> Array[Unit]:
	var result: Array[Unit] = []
	for unit: Unit in units:
		if is_instance_valid(unit) and not unit.is_exhausted():
			result.append(unit)
	return result
