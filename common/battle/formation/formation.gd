class_name Formation
extends Node


var team: Team:
	get:
		if not team:
			team = get_parent()
		
		return team

var units: Array[Unit]

@onready var behaviour_tree: BehaviourTree = $BehaviourTree


func _ready():
	behaviour_tree.blackboard["formation"] = self


func _physics_process(delta: float):
	behaviour_tree.tick_tree(delta)


func get_center_position() -> Vector3:
	var result := Vector3()
	for unit: Unit in get_active_units():
		result += unit.global_transform.origin

	return result / units.size()


func get_active_units() -> Array[Unit]:
	var result: Array[Unit] = []
	for unit: Unit in units:
		if is_instance_valid(unit) && not unit.is_exhausted():
			result.append(unit)

	return result
