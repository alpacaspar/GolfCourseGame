extends Node


var full_team = []
var battle_team = []


func get_battle_team():
	return battle_team


func add_golfer(golfer):
	full_team.append(golfer)


func remove_golfer(golfer):
	full_team.erase(golfer)


func put_golfer_in_battle_team(golfer):
	battle_team.append(golfer)
	

func remove_golfer_from_battle_team(golfer):
	battle_team.erase(golfer)
