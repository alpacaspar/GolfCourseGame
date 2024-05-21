class_name AK

class EVENTS:

	const PLAY_AMBIENCE_BED = 40897922
	const PLAY_PLR_SWING = 3408384243
	const PLAY_PLR_FOOTSTEP = 3735612561
	const PLAY_X_DEBUG_SHORT_SOUND = 93216633
	const PLAY_TREELEAVES_RUSTLING = 460794023
	const PLAY_NPC_DAMAGE_HIT = 2372980991
	const STINGER = 78360149
	const PLAY_X_DEBUG_DISTANCE = 3502184788
	const PLAY_WIND_GUST = 563870990
	const PLAY_X_DEBUG_CONTINUOUS_SOUND = 3634679436
	const TEMP_EVENT = 1057566954
	const STOP_TREELEAVES_RUSTLING = 4117275841
	const PLAY_PLR_DAMAGE_HIT = 2351148374
	const PLAY_INT_BALL_HIT = 924169741
	const STOP_MUS_BATTLE = 2037286166
	const PLAY_MUS_BATTLE = 353794020
	const PLAY_NPC_FOOTSTEP = 3866133272

	const _dict = {
		"play_ambience_bed": PLAY_AMBIENCE_BED,
		"play_plr_swing": PLAY_PLR_SWING,
		"play_plr_footstep": PLAY_PLR_FOOTSTEP,
		"play_x_debug_short_sound": PLAY_X_DEBUG_SHORT_SOUND,
		"play_treeLeaves_rustling": PLAY_TREELEAVES_RUSTLING,
		"play_npc_damage_hit": PLAY_NPC_DAMAGE_HIT,
		"Stinger": STINGER,
		"play_x_debug_distance": PLAY_X_DEBUG_DISTANCE,
		"play_wind_gust": PLAY_WIND_GUST,
		"play_x_debug_continuous_sound": PLAY_X_DEBUG_CONTINUOUS_SOUND,
		"temp_event": TEMP_EVENT,
		"stop_treeLeaves_rustling": STOP_TREELEAVES_RUSTLING,
		"play_plr_damage_hit": PLAY_PLR_DAMAGE_HIT,
		"play_int_ball_hit": PLAY_INT_BALL_HIT,
		"stop_mus_battle": STOP_MUS_BATTLE,
		"play_mus_battle": PLAY_MUS_BATTLE,
		"play_npc_footstep": PLAY_NPC_FOOTSTEP
	}

class STATES:

	class INGAME:
		const GROUP = 984691642

		class STATE:
			const EXPLORE = 579523862
			const NONE = 748895195
			const DIALOGUE = 3930136735
			const BATTLE = 2937832959

	class BATTLE_STATE:
		const GROUP = 2739846761

		class STATE:
			const NONE = 748895195
			const BATTLE_IN_PROGRESS = 2330123519
			const BATTLE_START = 2706291346
			const BATTLE_END = 461545889

	const _dict = {
		"InGame": {
			"GROUP": 984691642,
			"STATE": {
				"Explore": 579523862,
				"None": 748895195,
				"Dialogue": 3930136735,
				"Battle": 2937832959,
			}
		},
		"Battle_State": {
			"GROUP": 2739846761,
			"STATE": {
				"None": 748895195,
				"Battle_In_Progress": 2330123519,
				"Battle_Start": 2706291346,
				"Battle_End": 461545889
			}
		}
	}

class SWITCHES:

	class DEBUG_DISTANCE:
		const GROUP = 1611159812

		class SWITCH:
			const DISTANCE_100 = 1181406900
			const DISTANCE_015 = 1265441999
			const DISTANCE_055 = 1198331547
			const DISTANCE_000 = 1282219709
			const DISTANCE_020 = 1248664407
			const DISTANCE_040 = 1215109233
			const DISTANCE_080 = 1147998661
			const DISTANCE_090 = 1131221074
			const DISTANCE_035 = 1231886817
			const DISTANCE_045 = 1215109236
			const DISTANCE_025 = 1248664402
			const DISTANCE_065 = 1181553966
			const DISTANCE_075 = 1164776381
			const DISTANCE_010 = 1265441994
			const DISTANCE_005 = 1282219704
			const DISTANCE_030 = 1231886820
			const DISTANCE_060 = 1181553963
			const DISTANCE_070 = 1164776376
			const DISTANCE_050 = 1198331550
			const DISTANCE_095 = 1131221079
			const DISTANCE_085 = 1147998656

	class PLR_FOOTSTEP_SURFACE:
		const GROUP = 1625036798

		class SWITCH:
			const SAND = 803837735
			const GRASS = 4248645337
			const GRAVEL = 2185786256
			const PAVEMENT = 2830102203
			const WOOD = 2058049674

	class INT_COLLISION_SURFACE:
		const GROUP = 1829899313

		class SWITCH:
			const GRAVEL = 2185786256
			const WOOD = 2058049674
			const PAVEMENT = 2830102203
			const SAND = 803837735
			const GRASS = 4248645337

	class PLR_FOOTSTEP_INTENTION:
		const GROUP = 2218818815

		class SWITCH:
			const RUN = 712161704
			const WALK = 2108779966

	const _dict = {
		"debug_distance": {
			"GROUP": 1611159812,
			"SWITCH": {
				"distance_100": 1181406900,
				"distance_015": 1265441999,
				"distance_055": 1198331547,
				"distance_000": 1282219709,
				"distance_020": 1248664407,
				"distance_040": 1215109233,
				"distance_080": 1147998661,
				"distance_090": 1131221074,
				"distance_035": 1231886817,
				"distance_045": 1215109236,
				"distance_025": 1248664402,
				"distance_065": 1181553966,
				"distance_075": 1164776381,
				"distance_010": 1265441994,
				"distance_005": 1282219704,
				"distance_030": 1231886820,
				"distance_060": 1181553963,
				"distance_070": 1164776376,
				"distance_050": 1198331550,
				"distance_095": 1131221079,
				"distance_085": 1147998656,
			}
		},
		"plr_footstep_surface": {
			"GROUP": 1625036798,
			"SWITCH": {
				"sand": 803837735,
				"grass": 4248645337,
				"gravel": 2185786256,
				"pavement": 2830102203,
				"wood": 2058049674,
			}
		},
		"int_collision_surface": {
			"GROUP": 1829899313,
			"SWITCH": {
				"gravel": 2185786256,
				"wood": 2058049674,
				"pavement": 2830102203,
				"sand": 803837735,
				"grass": 4248645337
			}
		},
		"plr_footstep_intention": {
			"GROUP": 2218818815,
			"SWITCH": {
				"run": 712161704,
				"walk": 2108779966,
			}
		}
	}

class GAME_PARAMETERS:

	const FOOTSTEP_VOLUME = 511984960
	const WIND_INTENSITY = 855296609
	const MUS_VOLUME = 889708287
	const SFX_VOLUME = 1564184899
	const DIA_VOLUME = 2261376858
	const DEBUG_DISTANCE = 1611159812

	const _dict = {
		"footstep_volume": FOOTSTEP_VOLUME,
		"wind_intensity": WIND_INTENSITY,
		"mus_volume": MUS_VOLUME,
		"sfx_volume": SFX_VOLUME,
		"dia_volume": DIA_VOLUME,
		"debug_distance": DEBUG_DISTANCE
	}

class TRIGGERS:

	const TEST = 3157003241

	const _dict = {
		"Test": TEST
	}

class BANKS:

	const INIT = 1355168291
	const IN_GAME_SOUNDBANK = 1472650531
	const DEBUG_SOUNDBANK = 56103612

	const _dict = {
		"Init": INIT,
		"in_game_soundbank": IN_GAME_SOUNDBANK,
		"debug_soundbank": DEBUG_SOUNDBANK
	}

class BUSSES:

	const CINEMATIC_MASTER = 2536650578
	const AMBIENCE_MASTER = 143634621
	const NPC_MASTER = 3362801048
	const INTERACTIBLE_MASTER = 1943222575
	const UI_MASTER = 1698665495
	const DIA_MASTER = 3798835517
	const SFX_MASTER = 3222323340
	const MUS_MASTER = 3210384600
	const PLAYER_MASTER = 439959608
	const ENVIRONMENT_MASTER = 2126441370
	const MASTER_AUDIO_BUS = 3803692087

	const _dict = {
		"Cinematic Master": CINEMATIC_MASTER,
		"Ambience Master": AMBIENCE_MASTER,
		"NPC Master": NPC_MASTER,
		"Interactible Master": INTERACTIBLE_MASTER,
		"UI Master": UI_MASTER,
		"DIA Master": DIA_MASTER,
		"SFX Master": SFX_MASTER,
		"MUS Master": MUS_MASTER,
		"Player Master": PLAYER_MASTER,
		"Environment Master": ENVIRONMENT_MASTER,
		"Master Audio Bus": MASTER_AUDIO_BUS
	}

class AUX_BUSSES:

	const _dict = {}

class AUDIO_DEVICES:

	const SYSTEM = 3859886410
	const NO_OUTPUT = 2317455096

	const _dict = {
		"System": SYSTEM,
		"No_Output": NO_OUTPUT
	}

class EXTERNAL_SOURCES:

	const _dict = {}

