extends Node3D


@export var event_ref : String
#@onready var AkEvent : AkEvent3D = $AkEvent3D
# Called when the node enters the scene tree for the first time.

# For Wwise callbacks
var cookie_wrapper := CookieWrapper.new()
var callable := Callable(_event_callback)
var playing_id: int
var playing_segment_info: Dictionary

func _process(delta):
	playing_segment_info = Wwise.get_playing_segment_info(playing_id, false)
	#print("playing segment info: ", playing_segment_info)
	var remaining_until_exit_cue = playing_segment_info.iActiveDuration - playing_segment_info.iCurrentPosition
	# highlight moment = remaing_until_exit_cue + animation_cue_length_until_highlight
	#print("remaining until exit cue: ", remaining_until_exit_cue)

func _ready():
	cookie_wrapper.cookie = callable
	ak_register()
	ak_event_post(event_ref)


func ak_register():
	Wwise.register_game_obj(self, get_name())


func ak_event_post(event_name: String): # AK_END_OF_EVENT
	Wwise.post_event_callback(event_name, AkUtils.AK_MUSIC_SYNC_ENTRY | AkUtils.AK_ENABLE_GET_MUSIC_PLAY_POSITION, self, cookie_wrapper)
	# AK_DURATION will trigger a callback every time a clip starts
	# AkUtils.AK_ENABLE_GET_MUSIC_PLAY_POSITION
	# AkUtils.AK_DURATION
	print("Event name: ", event_name)


func _event_callback(data):
		# Callbacks are done from the sound engine's main thread. 
		# Gather all the information you need and return immediately.
	Thread.set_thread_safety_checks_enabled(false)
	playing_id = data.playingID
	
	#playing_segment_info = Wwise.get_playing_segment_info(playing_id, false)
	#print("playing segment info: ", playing_segment_info)

func ak_stop_event():
	Wwise.stop_event(playing_id, 1000, AkUtils.AK_CURVE_LINEAR) # fade time is in ms


func ak_unregister():
	#await get_tree().create_timer(1.0).timeout
	Wwise.unregister_game_obj(self)
