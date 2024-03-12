class_name Team
extends Node


var commander: Unit
var formations: Array

var units: Array:
	get:
		var result := []
		for formation in formations:
			result += formation.units
		
		return result

func setup(new_commander: Unit, new_formations: Array):
	commander = new_commander
	formations = new_formations


func update_tactics(tactic):
	pass