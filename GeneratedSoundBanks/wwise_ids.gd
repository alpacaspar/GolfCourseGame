class_name AK

class EVENTS:

	const STOP_MUS_BATTLE = 2037286166
	const TEMPORARY_EVENT = 4037565531
	const PLAY_X_DEBUG_SHORT_SOUND = 93216633
	const PLAY_AMBIENCE_BED = 40897922
	const PLAY_NPC_DAMAGE_HIT = 2372980991
	const PLAY_X_DEBUG_DISTANCE = 3502184788
	const PLAY_PLR_FOOTSTEP = 3735612561
	const STOP_TREELEAVES_RUSTLING = 4117275841
	const PLAY_MUS_BATTLE = 353794020
	const PLAY_X_DEBUG_CONTINUOUS_SOUND = 3634679436
	const PLAY_INT_BALL_HIT = 924169741
	const PLAY_WIND_GUST = 563870990
	const PLAY_NPC_FOOTSTEP = 3866133272
	const PLAY_PLR_DAMAGE_HIT = 2351148374
	const PLAY_PLR_SWING = 3408384243
	const PLAY_TREELEAVES_RUSTLING = 460794023
	const STINGER = 78360149

	const _dict = {
		"stop_mus_battle": STOP_MUS_BATTLE,
		"temporary_event": TEMPORARY_EVENT,
		"play_x_debug_short_sound": PLAY_X_DEBUG_SHORT_SOUND,
		"play_ambience_bed": PLAY_AMBIENCE_BED,
		"play_npc_damage_hit": PLAY_NPC_DAMAGE_HIT,
		"play_x_debug_distance": PLAY_X_DEBUG_DISTANCE,
		"play_plr_footstep": PLAY_PLR_FOOTSTEP,
		"stop_treeLeaves_rustling": STOP_TREELEAVES_RUSTLING,
		"play_mus_battle": PLAY_MUS_BATTLE,
		"play_x_debug_continuous_sound": PLAY_X_DEBUG_CONTINUOUS_SOUND,
		"play_int_ball_hit": PLAY_INT_BALL_HIT,
		"play_wind_gust": PLAY_WIND_GUST,
		"play_npc_footstep": PLAY_NPC_FOOTSTEP,
		"play_plr_damage_hit": PLAY_PLR_DAMAGE_HIT,
		"play_plr_swing": PLAY_PLR_SWING,
		"play_treeLeaves_rustling": PLAY_TREELEAVES_RUSTLING,
		"Stinger": STINGER
	}

class STATES:

	class INGAME:
		const GROUP = 984691642

		class STATE:
			const NONE = 748895195
			const EXPLORE = 579523862
			const DIALOGUE = 3930136735
			const BATTLE = 2937832959

	class BATTLE_STATE:
		const GROUP = 2739846761

		class STATE:
			const BATTLE_START = 2706291346
			const BATTLE_IN_PROGRESS = 2330123519
			const BATTLE_END = 461545889
			const NONE = 748895195

	const _dict = {
		"InGame": {
			"GROUP": 984691642,
			"STATE": {
				"None": 748895195,
				"Explore": 579523862,
				"Dialogue": 3930136735,
				"Battle": 2937832959
			}
		},
		"Battle_State": {
			"GROUP": 2739846761,
			"STATE": {
				"Battle_Start": 2706291346,
				"Battle_In_Progress": 2330123519,
				"Battle_End": 461545889,
				"None": 748895195,
			}
		}
	}

class SWITCHES:

	class NPC_FOOTSTEP_INTENTION:
		const GROUP = 1720825930

		class SWITCH:
			const RUN = 712161704
			const WALK = 2108779966

	class PLR_FOOTSTEP_SURFACE:
		const GROUP = 1625036798

		class SWITCH:
			const SAND = 803837735
			const GRAVEL = 2185786256
			const WOOD = 2058049674
			const GRASS = 4248645337
			const PAVEMENT = 2830102203

	class NPC_FOOTSTEP_SURFACE:
		const GROUP = 3379231435

		class SWITCH:
			const GRASS = 4248645337
			const SAND = 803837735
			const GRAVEL = 2185786256
			const WOOD = 2058049674
			const PAVEMENT = 2830102203

	class INT_COLLISION_SURFACE:
		const GROUP = 1829899313

		class SWITCH:
			const GRASS = 4248645337
			const GRAVEL = 2185786256
			const PAVEMENT = 2830102203
			const SAND = 803837735
			const WOOD = 2058049674

	class PLR_FOOTSTEP_INTENTION:
		const GROUP = 2218818815

		class SWITCH:
			const WALK = 2108779966
			const RUN = 712161704

	class DEBUG_DISTANCE:
		const GROUP = 1611159812

		class SWITCH:
			const DISTANCE_010 = 1265441994
			const DISTANCE_020 = 1248664407
			const DISTANCE_030 = 1231886820
			const DISTANCE_040 = 1215109233
			const DISTANCE_050 = 1198331550
			const DISTANCE_060 = 1181553963
			const DISTANCE_070 = 1164776376
			const DISTANCE_080 = 1147998661
			const DISTANCE_090 = 1131221074
			const DISTANCE_100 = 1181406900
			const DISTANCE_015 = 1265441999
			const DISTANCE_055 = 1198331547
			const DISTANCE_000 = 1282219709
			const DISTANCE_005 = 1282219704
			const DISTANCE_065 = 1181553966
			const DISTANCE_045 = 1215109236
			const DISTANCE_075 = 1164776381
			const DISTANCE_035 = 1231886817
			const DISTANCE_095 = 1131221079
			const DISTANCE_025 = 1248664402
			const DISTANCE_085 = 1147998656

	const _dict = {
		"npc_footstep_intention": {
			"GROUP": 1720825930,
			"SWITCH": {
				"run": 712161704,
				"walk": 2108779966,
			}
		},
		"plr_footstep_surface": {
			"GROUP": 1625036798,
			"SWITCH": {
				"sand": 803837735,
				"gravel": 2185786256,
				"wood": 2058049674,
				"grass": 4248645337,
				"pavement": 2830102203,
			}
		},
		"npc_footstep_surface": {
			"GROUP": 3379231435,
			"SWITCH": {
				"grass": 4248645337,
				"sand": 803837735,
				"gravel": 2185786256,
				"wood": 2058049674,
				"pavement": 2830102203
			}
		},
		"int_collision_surface": {
			"GROUP": 1829899313,
			"SWITCH": {
				"grass": 4248645337,
				"gravel": 2185786256,
				"pavement": 2830102203,
				"sand": 803837735,
				"wood": 2058049674,
			}
		},
		"plr_footstep_intention": {
			"GROUP": 2218818815,
			"SWITCH": {
				"walk": 2108779966,
				"run": 712161704,
			}
		},
		"debug_distance": {
			"GROUP": 1611159812,
			"SWITCH": {
				"distance_010": 1265441994,
				"distance_020": 1248664407,
				"distance_030": 1231886820,
				"distance_040": 1215109233,
				"distance_050": 1198331550,
				"distance_060": 1181553963,
				"distance_070": 1164776376,
				"distance_080": 1147998661,
				"distance_090": 1131221074,
				"distance_100": 1181406900,
				"distance_015": 1265441999,
				"distance_055": 1198331547,
				"distance_000": 1282219709,
				"distance_005": 1282219704,
				"distance_065": 1181553966,
				"distance_045": 1215109236,
				"distance_075": 1164776381,
				"distance_035": 1231886817,
				"distance_095": 1131221079,
				"distance_025": 1248664402,
				"distance_085": 1147998656,
			}
		}
	}

class GAME_PARAMETERS:

	const WIND_INTENSITY = 855296609
	const DEBUG_DISTANCE = 1611159812
	const DIA_VOLUME = 2261376858
	const FOOTSTEP_VOLUME = 511984960
	const SFX_VOLUME = 1564184899
	const GOLF_CAR_RPM = 534386172
	const MUS_VOLUME = 889708287
	const TREE_AMOUNT = 3095779176

	const _dict = {
		"wind_intensity": WIND_INTENSITY,
		"debug_distance": DEBUG_DISTANCE,
		"dia_volume": DIA_VOLUME,
		"footstep_volume": FOOTSTEP_VOLUME,
		"sfx_volume": SFX_VOLUME,
		"golf_car_rpm": GOLF_CAR_RPM,
		"mus_volume": MUS_VOLUME,
		"tree_amount": TREE_AMOUNT
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
	const NPC_MASTER = 3362801048
	const MUS_MASTER = 3210384600
	const MASTER_AUDIO_BUS = 3803692087
	const DIA_MASTER = 3798835517
	const SFX_MASTER = 3222323340
	const AMBIENCE_MASTER = 143634621
	const PLAYER_MASTER = 439959608
	const ENVIRONMENT_MASTER = 2126441370
	const INTERACTIBLE_MASTER = 1943222575
	const UI_MASTER = 1698665495

	const _dict = {
		"Cinematic Master": CINEMATIC_MASTER,
		"NPC Master": NPC_MASTER,
		"MUS Master": MUS_MASTER,
		"Master Audio Bus": MASTER_AUDIO_BUS,
		"DIA Master": DIA_MASTER,
		"SFX Master": SFX_MASTER,
		"Ambience Master": AMBIENCE_MASTER,
		"Player Master": PLAYER_MASTER,
		"Environment Master": ENVIRONMENT_MASTER,
		"Interactible Master": INTERACTIBLE_MASTER,
		"UI Master": UI_MASTER
	}

class AUX_BUSSES:

	const _dict = {}

class AUDIO_DEVICES:

	const NO_OUTPUT = 2317455096
	const SYSTEM = 3859886410

	const _dict = {
		"No_Output": NO_OUTPUT,
		"System": SYSTEM
	}

class EXTERNAL_SOURCES:

	const _dict = {}

