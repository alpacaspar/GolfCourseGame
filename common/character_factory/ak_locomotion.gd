extends Node

@onready var activity_timer : Timer = $ActivityTimer
@onready var decay_timer : Timer = $DecayTimer
@export var curve : Curve



func play_footstep():
	Wwise.register_game_obj(self, "AkTest")
	Wwise.post_event("play_plr_footstep", self)
	activity_timer_start()

func activity_timer_start():
	if activity_timer.time_left == 0:
		Wwise.set_rtpc_value("footstep_volume", 1, self)
		decay_timer.start()
	activity_timer.start()
	Wwise.set_rtpc_value("footstep_volume", curve.sample(decay_timer.time_left / decay_timer.wait_time), self)
	# Wwise.set_rtpc_value("footstep_volume", 0, self)
	

func play_swing():
	Wwise.register_game_obj(self, "AkTest")
	Wwise.post_event("play_plr_swing", self)
	
func play_test():
	Wwise.register_game_obj(self, "AkTest")
	Wwise.post_event("play_x_debug_distance", self)


