extends Node3D


@export var curve : Curve

@onready var activity_timer : Timer = $ActivityTimer
@onready var decay_timer : Timer = $DecayTimer


func play_footstep():
	Wwise.register_game_obj(self, get_name())
	Wwise.set_3d_position(self, global_transform)
	Wwise.post_event("play_plr_footstep", self)
	start_activity_timer()


func start_activity_timer():
	if activity_timer.time_left == 0:
		Wwise.set_rtpc_value("footstep_volume", 1, self)
		decay_timer.start()

	activity_timer.start()
	Wwise.set_rtpc_value("footstep_volume", curve.sample(decay_timer.time_left / decay_timer.wait_time), self)


func play_swing():
	Wwise.register_game_obj(self, get_name())
	Wwise.set_3d_position(self, global_transform)
	Wwise.post_event("play_plr_swing", self)
