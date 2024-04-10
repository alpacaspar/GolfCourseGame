extends StaticBody3D

@export var objectref : Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func ak_event_post():
	Wwise.register_game_obj(get_parent(), get_parent().get_name())
	Wwise.post_event("play_plr_swing", get_parent())
