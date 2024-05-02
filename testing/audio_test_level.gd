extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_key_pressed(KEY_P):
		Wwise.register_game_obj(self, "Node3D")
		Wwise.post_event("play_x_debug_distance", self)
	if Input.is_key_pressed(KEY_M):
		# Wwise.set_state("MusicState", "Calm")
		pass
