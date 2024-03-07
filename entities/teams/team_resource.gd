class_name TeamResource
extends Resource


@export var commander := RivalResource.new()
@export var members: Array[GolferResource] = []

## A dictionary containing the members of the team, grouped by role.
var formations: Dictionary:
	get:
		var selection = [commander] + members

		var roles: Array[Role] = []
		for member in selection:
			if !roles.has(member.role):
				roles.append(member.role)

		var result = {}
		for role in roles:
			result[role] = []
			for member in selection:
				if member.role == role:
					result[role].append(member)
					selection.erase(member)
		
		return result

var size: int:
	get:
		# Add one for the commander.
		return 1 + members.size()


func _init():
	pass