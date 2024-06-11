class_name PlayerTeamResource
extends TeamResource


@export var benched_golfers: Array[GolferResource] = []

var player: GolferResource:
	get: return leader
	set(value): leader = value


func add_to_bench(golfer: GolferResource):
	if not benched_golfers.has(golfer):
		benched_golfers.append(golfer)


func remove_from_bench(golfer: GolferResource):
	if benched_golfers.has(golfer):
		benched_golfers.erase(golfer)


func get_non_team_golfers() -> Array[GolferResource]:
	var result: Array[GolferResource] = []

	for golfer: GolferResource in benched_golfers:
		if not units.has(golfer):
			result.append(golfer)

	return result
