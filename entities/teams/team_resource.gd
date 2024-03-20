class_name TeamResource
extends Resource


@export var commander := RivalResource.new()
@export var formations: Array[FormationResource] = []

var size: int:
	get:
		# 1 for the commander.
		var result := 1
		for formation in formations:
			result += formation.units.size()
		
		return result
