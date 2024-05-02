extends Node


#@export var event_ref : String
#@onready var AkEvent : AkEvent3D = $AkEvent3D
# Called when the node enters the scene tree for the first time.

# For Wwise callbacks
var cookie_wrapper := CookieWrapper.new()
var callable := Callable(_event_callback)
var playingID: int


func _ready():
	cookie_wrapper.cookie = callable


func ak_register():
	Wwise.register_game_obj(self, get_name())
	#Wwise.set_3d_position(self, self.global_transform)


func ak_event_post(event_name): # AK_END_OF_EVENT
	Wwise.post_event_callback(event_name, AkUtils.AK_DURATION, self, cookie_wrapper)
	#AkEvent.post_event()


func _event_callback(data):
		# Callbacks are done from the sound engine's main thread. 
		# Gather all the information you need and return immediately.
	Thread.set_thread_safety_checks_enabled(false)
	playingID = data.playingID


func ak_stop_event():
	Wwise.stop_event(playingID, 1000, AkUtils.AK_CURVE_LINEAR) # fade time is in ms


func ak_unregister():
	#await get_tree().create_timer(1.0).timeout
	Wwise.unregister_game_obj(self)
