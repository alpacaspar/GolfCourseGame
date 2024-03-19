extends AkEvent3D


func play_footstep():
	Wwise.register_game_obj(self, "AkEvent3D")
	Wwise.post_event("play_plr_footstep", self)


func play_swing():
	Wwise.register_game_obj(self, "AkEvent3D")
	Wwise.post_event("play_plr_swing", self)
