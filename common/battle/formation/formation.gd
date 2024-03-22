class_name Formation
extends Node


var team: Team:
	get:
		if not team:
			team = get_parent()
		
		return team

var units: Array[Unit]

var target_formation: Formation:
	get:
		if get_active_units().is_empty():
			return null

		if behaviour_tree and behaviour_tree.blackboard.has("target_formation"):
			return behaviour_tree.blackboard["target_formation"]
		
		return null

@onready var behaviour_tree: BehaviourTree = $BehaviourTree


func _ready():
	behaviour_tree.blackboard["formation"] = self


func _physics_process(delta: float):
	behaviour_tree.process_tree(delta)


func get_active_units() -> Array[Unit]:
	var result: Array[Unit] = []
	for unit: Unit in units:
		if is_instance_valid(unit) && not unit.is_exhausted():
			result.append(unit)

	return result
