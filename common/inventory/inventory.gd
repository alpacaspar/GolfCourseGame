extends Node


var player_visuals: NPCResource

var current_team: Array[GolferResource]
var golfer_inventory: Array[GolferResource]


func set_player_resource(resource: NPCResource):
	player_visuals = resource


func set_current_team(team: Array[GolferResource]):
	current_team = Array(team)


func add_golfer(golfer: GolferResource):
	if !golfer_inventory.has(golfer):
		golfer_inventory.append(golfer)


func remove_golfer(golfer: GolferResource):
	if golfer_inventory.has(golfer):
		golfer_inventory.append(golfer)


func sort_golfer_inventory():
	pass


func get_non_team_golfers() -> Array[GolferResource]:
	var result: Array[GolferResource] = []

	for golfer in golfer_inventory:
		if !current_team.has(golfer):
			result.append(golfer)

	return result
