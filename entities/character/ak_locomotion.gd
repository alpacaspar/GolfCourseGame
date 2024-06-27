extends Node3D

const MOVE_BLEND_PARAMETER: StringName = "parameters/MoveBlend/blend_amount"

@export var character: Character
@export_group("footsteps")
@export var footstep_volume_curve: Curve
@export var terrain3d_storage: Terrain3DStorage
@export var terrain3d_texture_list: Terrain3DTextureList

@onready var activity_timer: Timer = $ActivityTimer
@onready var decay_timer: Timer = $DecayTimer


func _ready():
	Wwise.register_game_obj(self, get_name())

func play_footstep():
	Wwise.set_3d_position(self, global_transform)
	# TODO: Implement NPC vs PLR detection
	var character_type: String = "plr" # temporary
	if character.npc.has_meta("is_player"):
		character_type = "plr"
	else:
		character_type = "npc"
	set_associated_switch(character_type, _get_terrain_material_name(global_position))
	
	var intention_type: String = ""
	var move_blend: float = character.animation_tree.get(MOVE_BLEND_PARAMETER)
	if move_blend < 0.5:
		intention_type = "walk"
	elif move_blend > 0.5:
		intention_type = "run"
	
	
	Wwise.set_switch(character_type + "_footstep_intention", intention_type, self)
	Wwise.post_event("play_" + character_type + "_footstep", self)
	start_activity_timer()


func set_associated_switch(character_type: String, texture_name: String):
	# TODO: implement character_type
	if texture_name == "Fairway" or texture_name == "Green" or texture_name == "Semirough":
		Wwise.set_switch(character_type + "_footstep_surface", "grass", self)
	if texture_name == "Bunker":
		Wwise.set_switch(character_type + "_footstep_surface", "sand", self)


func play_knockout():
	Wwise.set_3d_position(self, global_transform)
	Wwise.post_event("play_plr_knockout", self)


func start_activity_timer():
	if activity_timer.time_left == 0:
		Wwise.set_rtpc_value("footstep_volume", 1, self)
		decay_timer.start()

	activity_timer.start()
	Wwise.set_rtpc_value("footstep_volume", footstep_volume_curve.sample(decay_timer.time_left / decay_timer.wait_time), self)


func play_swing():
	Wwise.set_3d_position(self, global_transform)
	Wwise.post_event("play_plr_swing", self)


func _get_terrain_material_name(origin: Vector3) -> String:
	var terrain_id := terrain3d_storage.get_texture_id(origin)
	return terrain3d_texture_list.get_texture(roundi(terrain_id.x)).name
