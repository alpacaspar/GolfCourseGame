class_name Team
extends Node


var commander: Unit
var formations: Array[Formation]

var units: Array[Unit]:
	get:
		var result: Array[Unit] = []
		result.append(commander)
		
		for formation: Formation in formations:
			result += formation.units
		
		return result
