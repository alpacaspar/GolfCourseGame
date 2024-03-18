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
	for unit: Unit in units:
		result += unit.global_transform.origin

	return result / units.size()
