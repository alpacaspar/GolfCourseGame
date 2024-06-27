extends Node


const SWITCH_GROUP_BALL = "int_ball_collision_type"


func try_set_switch(game_object: Node, collider: Node, switch_group: StringName) -> bool:
	var groups := collider.get_groups()
	if not AK.SWITCHES._dict.has(switch_group):
		print_debug("switch group,", switch_group, " does not exist")
		return false
	for group: StringName in groups:
		if AK.SWITCHES._dict[switch_group]["SWITCH"].has(group):
			Wwise.set_switch(switch_group, group, game_object)
			return true
	
	return false
