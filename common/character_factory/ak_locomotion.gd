extends Node


func play_footstep():
	Wwise.register_game_obj(self, "AkTest")
	Wwise.post_event("play_plr_footstep", self)


func play_swing():
	Wwise.register_game_obj(self, "AkTest")
	Wwise.post_event("play_plr_swing", self)
	
func play_test():
	Wwise.register_game_obj(self, "AkTest")
	Wwise.post_event("play_x_debug_distance", self)
