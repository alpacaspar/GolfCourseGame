class_name AK

class EVENTS:

	const PLAY_AMBIENCE_BED = 40897922
	const PLAY_TREELEAVES_RUSTLING = 460794023
	const PLAY_X_DEBUG_DISTANCE = 3502184788
	const PLAY_WIND_GUST = 563870990
	const PLAY_X_DEBUG_CONTINUOUS_SOUND = 3634679436
	const STINGER = 78360149
	const PLAY_PLR_FOOTSTEP = 3735612561
	const PLAY_PLR_SWING = 3408384243
	const STOP_TREELEAVES_RUSTLING = 4117275841

	const _dict = {
		"play_ambience_bed": PLAY_AMBIENCE_BED,
		"play_treeLeaves_rustling": PLAY_TREELEAVES_RUSTLING,
		"play_x_debug_distance": PLAY_X_DEBUG_DISTANCE,
		"play_wind_gust": PLAY_WIND_GUST,
		"play_x_debug_continuous_sound": PLAY_X_DEBUG_CONTINUOUS_SOUND,
		"Stinger": STINGER,
		"play_plr_footstep": PLAY_PLR_FOOTSTEP,
		"play_plr_swing": PLAY_PLR_SWING,
		"stop_treeLeaves_rustling": STOP_TREELEAVES_RUSTLING
	}

class STATES:

	class INGAME:
		const GROUP = 984691642

		class STATE:
			const NONE = 748895195
			const BATTLE = 2937832959
			const EXPLORE = 579523862
			const DIALOGUE = 3930136735

	const _dict = {
		"InGame": {
			"GROUP": 984691642,
			"STATE": {
				"None": 748895195,
				"Battle": 2937832959,
				"Explore": 579523862,
				"Dialogue": 3930136735
			}
		}
	}

class SWITCHES:

	class DEBUG_DISTANCE:
		const GROUP = 1611159812

		class SWITCH:
			const DISTANCE_080 = 1147998661
			const DISTANCE_100 = 1181406900
			const DISTANCE_060 = 1181553963
			const DISTANCE_085 = 1147998656
			const DISTANCE_095 = 1131221079
			const DISTANCE_090 = 1131221074
			const DISTANCE_070 = 1164776376
			const DISTANCE_015 = 1265441999
			const DISTANCE_005 = 1282219704
			const DISTANCE_020 = 1248664407
			const DISTANCE_030 = 1231886820
			const DISTANCE_000 = 1282219709
			const DISTANCE_010 = 1265441994
			const DISTANCE_040 = 1215109233
			const DISTANCE_050 = 1198331550
			const DISTANCE_025 = 1248664402
			const DISTANCE_035 = 1231886817
			const DISTANCE_075 = 1164776381
			const DISTANCE_065 = 1181553966
			const DISTANCE_055 = 1198331547
			const DISTANCE_045 = 1215109236

	const _dict = {
		"debug_distance": {
			"GROUP": 1611159812,
			"SWITCH": {
				"distance_080": 1147998661,
				"distance_100": 1181406900,
				"distance_060": 1181553963,
				"distance_085": 1147998656,
				"distance_095": 1131221079,
				"distance_090": 1131221074,
				"distance_070": 1164776376,
				"distance_015": 1265441999,
				"distance_005": 1282219704,
				"distance_020": 1248664407,
				"distance_030": 1231886820,
				"distance_000": 1282219709,
				"distance_010": 1265441994,
				"distance_040": 1215109233,
				"distance_050": 1198331550,
				"distance_025": 1248664402,
				"distance_035": 1231886817,
				"distance_075": 1164776381,
				"distance_065": 1181553966,
				"distance_055": 1198331547,
				"distance_045": 1215109236
			}
		}
	}

class GAME_PARAMETERS:

	const FOOTSTEP_VOLUME = 511984960
	const WIND_INTENSITY = 855296609
	const DEBUG_DISTANCE = 1611159812

	const _dict = {
		"footstep_volume": FOOTSTEP_VOLUME,
		"wind_intensity": WIND_INTENSITY,
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

	const MASTER_AUDIO_BUS = 3803692087

	const _dict = {
		"Master Audio Bus": MASTER_AUDIO_BUS
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

