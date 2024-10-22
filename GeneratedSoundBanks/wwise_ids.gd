class_name AK

class EVENTS:

	const PLAY_AMBIENCE_BED = 40897922
	const TEMPORARY_EVENT = 4037565531
	const PLAY_INT_BALL_HIT = 924169741
	const STINGER = 78360149
	const PLAY_MUS_BATTLE_MAIN = 4114194068
	const STOP_MUS_BATTLE = 2037286166
	const PLAY_MUS_CREATOR = 469868902
	const PLAY_MUS_MANAGER = 3436960487
	const PLAY_MUS_BATTLE_INTRO = 3189784343
	const PLAY_PLR_FOOTSTEP = 3735612561
	const PLAY_PLR_DAMAGE_HIT = 2351148374
	const PLAY_UI_CLICK_PRIMARY = 1386151314
	const PLAY_UI_CLICK_RANDOMIZE = 3204576333
	const PLAY_UI_CLICK_SECONDARY = 320147726
	const PLAY_PLR_SWING = 3408384243
	const PLAY_TREELEAVES_RUSTLING = 460794023
	const PLAY_MUS_BATTLE_FINISH = 1540042386
	const PLAY_NPC_FOOTSTEP = 3866133272
	const PLAY_UI_UNCLICK_RELEASE = 2102308692
	const PLAY_NPC_DAMAGE_HIT = 2372980991
	const PLAY_X_DEBUG_CONTINUOUS_SOUND = 3634679436
	const PLAY_WIND_GUST = 563870990
	const PLAY_UI_CLICK_RESET = 274290669
	const PLAY_UI_CLICK_REDUCE = 3028660562
	const PLAY_UI_CLICK_HOLD = 3132575655
	const PLAY_UI_CLICK_INCREASE = 538507952
	const PLAY_X_DEBUG_SHORT_SOUND = 93216633
	const STOP_TREELEAVES_RUSTLING = 4117275841
	const PLAY_X_DEBUG_DISTANCE = 3502184788
	const PLAY_PLR_KNOCKOUT = 2786432683

	const _dict = {
		"play_ambience_bed": PLAY_AMBIENCE_BED,
		"temporary_event": TEMPORARY_EVENT,
		"play_int_ball_hit": PLAY_INT_BALL_HIT,
		"Stinger": STINGER,
		"play_mus_battle_main": PLAY_MUS_BATTLE_MAIN,
		"stop_mus_battle": STOP_MUS_BATTLE,
		"play_mus_creator": PLAY_MUS_CREATOR,
		"play_mus_manager": PLAY_MUS_MANAGER,
		"play_mus_battle_intro": PLAY_MUS_BATTLE_INTRO,
		"play_plr_footstep": PLAY_PLR_FOOTSTEP,
		"play_plr_damage_hit": PLAY_PLR_DAMAGE_HIT,
		"play_ui_click_primary": PLAY_UI_CLICK_PRIMARY,
		"play_ui_click_randomize": PLAY_UI_CLICK_RANDOMIZE,
		"play_ui_click_secondary": PLAY_UI_CLICK_SECONDARY,
		"play_plr_swing": PLAY_PLR_SWING,
		"play_treeLeaves_rustling": PLAY_TREELEAVES_RUSTLING,
		"play_mus_battle_finish": PLAY_MUS_BATTLE_FINISH,
		"play_npc_footstep": PLAY_NPC_FOOTSTEP,
		"play_ui_unclick_release": PLAY_UI_UNCLICK_RELEASE,
		"play_npc_damage_hit": PLAY_NPC_DAMAGE_HIT,
		"play_x_debug_continuous_sound": PLAY_X_DEBUG_CONTINUOUS_SOUND,
		"play_wind_gust": PLAY_WIND_GUST,
		"play_ui_click_reset": PLAY_UI_CLICK_RESET,
		"play_ui_click_reduce": PLAY_UI_CLICK_REDUCE,
		"play_ui_click_hold": PLAY_UI_CLICK_HOLD,
		"play_ui_click_increase": PLAY_UI_CLICK_INCREASE,
		"play_x_debug_short_sound": PLAY_X_DEBUG_SHORT_SOUND,
		"stop_treeLeaves_rustling": STOP_TREELEAVES_RUSTLING,
		"play_x_debug_distance": PLAY_X_DEBUG_DISTANCE,
		"play_plr_knockout": PLAY_PLR_KNOCKOUT
	}

class STATES:

	class DEBUG_STATE:
		const GROUP = 229901964

		class STATE:
			const DEBUG_STATE_1 = 369960656
			const NONE = 748895195

	class BATTLE_STATE:
		const GROUP = 2739846761

		class STATE:
			const NONE = 748895195
			const BATTLE_IN_PROGRESS = 2330123519
			const BATTLE_START = 2706291346
			const BATTLE_END = 461545889

	class INGAME:
		const GROUP = 984691642

		class STATE:
			const EXPLORE = 579523862
			const DIALOGUE = 3930136735
			const NONE = 748895195
			const BATTLE = 2937832959

	class DEBUG_STATE_01:
		const GROUP = 2276727602

		class STATE:
			const NONE = 748895195
			const DEBUG_STATE_1 = 369960656

	const _dict = {
		"Debug_State": {
			"GROUP": 229901964,
			"STATE": {
				"Debug_State_1": 369960656,
				"None": 748895195,
			}
		},
		"Battle_State": {
			"GROUP": 2739846761,
			"STATE": {
				"None": 748895195,
				"Battle_In_Progress": 2330123519,
				"Battle_Start": 2706291346,
				"Battle_End": 461545889,
			}
		},
		"InGame": {
			"GROUP": 984691642,
			"STATE": {
				"Explore": 579523862,
				"Dialogue": 3930136735,
				"None": 748895195,
				"Battle": 2937832959
			}
		},
		"Debug_State_01": {
			"GROUP": 2276727602,
			"STATE": {
				"None": 748895195,
				"Debug_State_1": 369960656,
			}
		}
	}

class SWITCHES:

	class DEBUG_DISTANCE:
		const GROUP = 1611159812

		class SWITCH:
			const DISTANCE_000 = 1282219709
			const DISTANCE_005 = 1282219704
			const DISTANCE_020 = 1248664407
			const DISTANCE_030 = 1231886820
			const DISTANCE_050 = 1198331550
			const DISTANCE_070 = 1164776376
			const DISTANCE_080 = 1147998661
			const DISTANCE_100 = 1181406900
			const DISTANCE_040 = 1215109233
			const DISTANCE_015 = 1265441999
			const DISTANCE_090 = 1131221074
			const DISTANCE_055 = 1198331547
			const DISTANCE_035 = 1231886817
			const DISTANCE_045 = 1215109236
			const DISTANCE_060 = 1181553963
			const DISTANCE_010 = 1265441994
			const DISTANCE_025 = 1248664402
			const DISTANCE_065 = 1181553966
			const DISTANCE_085 = 1147998656
			const DISTANCE_095 = 1131221079
			const DISTANCE_075 = 1164776381

	class INT_BALL_COLLISION_TYPE:
		const GROUP = 174688308

		class SWITCH:
			const GRASS = 4248645337
			const GRAVEL = 2185786256
			const WOOD = 2058049674
			const SAND = 803837735
			const PAVEMENT = 2830102203
			const GOLFCLUB = 2553113501
			const UNIT = 1304109583

	class NPC_FOOTSTEP_SURFACE:
		const GROUP = 3379231435

		class SWITCH:
			const WOOD = 2058049674
			const GRASS = 4248645337
			const GRAVEL = 2185786256
			const SAND = 803837735
			const PAVEMENT = 2830102203

	class NPC_FOOTSTEP_INTENTION:
		const GROUP = 1720825930

		class SWITCH:
			const WALK = 2108779966
			const RUN = 712161704

	class PLR_FOOTSTEP_INTENTION:
		const GROUP = 2218818815

		class SWITCH:
			const RUN = 712161704
			const WALK = 2108779966

	class PLR_FOOTSTEP_SURFACE:
		const GROUP = 1625036798

		class SWITCH:
			const SAND = 803837735
			const GRAVEL = 2185786256
			const GRASS = 4248645337
			const WOOD = 2058049674
			const PAVEMENT = 2830102203

	const _dict = {
		"debug_distance": {
			"GROUP": 1611159812,
			"SWITCH": {
				"distance_000": 1282219709,
				"distance_005": 1282219704,
				"distance_020": 1248664407,
				"distance_030": 1231886820,
				"distance_050": 1198331550,
				"distance_070": 1164776376,
				"distance_080": 1147998661,
				"distance_100": 1181406900,
				"distance_040": 1215109233,
				"distance_015": 1265441999,
				"distance_090": 1131221074,
				"distance_055": 1198331547,
				"distance_035": 1231886817,
				"distance_045": 1215109236,
				"distance_060": 1181553963,
				"distance_010": 1265441994,
				"distance_025": 1248664402,
				"distance_065": 1181553966,
				"distance_085": 1147998656,
				"distance_095": 1131221079,
				"distance_075": 1164776381,
			}
		},
		"int_ball_collision_type": {
			"GROUP": 174688308,
			"SWITCH": {
				"grass": 4248645337,
				"gravel": 2185786256,
				"wood": 2058049674,
				"sand": 803837735,
				"pavement": 2830102203,
				"golfclub": 2553113501,
				"unit": 1304109583,
			}
		},
		"npc_footstep_surface": {
			"GROUP": 3379231435,
			"SWITCH": {
				"wood": 2058049674,
				"grass": 4248645337,
				"gravel": 2185786256,
				"sand": 803837735,
				"pavement": 2830102203,
			}
		},
		"npc_footstep_intention": {
			"GROUP": 1720825930,
			"SWITCH": {
				"walk": 2108779966,
				"run": 712161704,
			}
		},
		"plr_footstep_intention": {
			"GROUP": 2218818815,
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
				"grass": 4248645337,
				"wood": 2058049674,
				"pavement": 2830102203
			}
		}
	}

class GAME_PARAMETERS:

	const MUS_VOLUME = 889708287
	const DIA_VOLUME = 2261376858
	const GOLF_CAR_RPM = 534386172
	const WIND_INTENSITY = 855296609
	const DEBUG_DISTANCE = 1611159812
	const FOOTSTEP_VOLUME = 511984960
	const TREE_AMOUNT = 3095779176
	const SFX_VOLUME = 1564184899

	const _dict = {
		"mus_volume": MUS_VOLUME,
		"dia_volume": DIA_VOLUME,
		"golf_car_rpm": GOLF_CAR_RPM,
		"wind_intensity": WIND_INTENSITY,
		"debug_distance": DEBUG_DISTANCE,
		"footstep_volume": FOOTSTEP_VOLUME,
		"tree_amount": TREE_AMOUNT,
		"sfx_volume": SFX_VOLUME
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

	const NPC_MASTER = 3362801048
	const INTERACTIBLE_MASTER = 1943222575
	const CINEMATIC_MASTER = 2536650578
	const SFX_MASTER = 3222323340
	const AMBIENCE_MASTER = 143634621
	const DIA_MASTER = 3798835517
	const MASTER_AUDIO_BUS = 3803692087
	const MUS_MASTER = 3210384600
	const UI_MASTER = 1698665495
	const PLAYER_MASTER = 439959608
	const ENVIRONMENT_MASTER = 2126441370

	const _dict = {
		"NPC Master": NPC_MASTER,
		"Interactible Master": INTERACTIBLE_MASTER,
		"Cinematic Master": CINEMATIC_MASTER,
		"SFX Master": SFX_MASTER,
		"Ambience Master": AMBIENCE_MASTER,
		"DIA Master": DIA_MASTER,
		"Master Audio Bus": MASTER_AUDIO_BUS,
		"MUS Master": MUS_MASTER,
		"UI Master": UI_MASTER,
		"Player Master": PLAYER_MASTER,
		"Environment Master": ENVIRONMENT_MASTER
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

