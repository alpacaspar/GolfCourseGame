class_name Team
extends Node


var commander: Unit
var formations: Array


func setup(new_commander: Unit, new_formations: Array):
	commander = new_commander
	formations = new_formations


func update_tactics(tactic):
	pass