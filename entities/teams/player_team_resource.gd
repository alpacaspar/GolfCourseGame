class_name PlayerTeamResource
extends TeamResource


@export var player: GolferResource:
	get: return leader
	set(value): leader = value

@export var team: Array[GolferResource]:
	get: return units
	set(value): units = value.duplicate()

@export var benched_golfers: Array[GolferResource] = []


func add_golfer(golfer: GolferResource):
	if !benched_golfers.has(golfer):
		benched_golfers.append(golfer)


func remove_golfer(golfer: GolferResource):
	if benched_golfers.has(golfer):
		benched_golfers.append(golfer)


func get_non_team_golfers() -> Array[GolferResource]:
	var result: Array[GolferResource] = []

	for golfer in benched_golfers:
		if !team.has(golfer):
			result.append(golfer)

	return result
