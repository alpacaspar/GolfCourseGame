class_name Formation
extends Node


var team: Node
var members: Array


func _physics_process(delta: float):
	#TODO: Implement formation logic.
	pass

func setup(current_team: Node, current_members: Array):
	team = current_team
	members = current_members


func set_tactic(tactic):
	pass