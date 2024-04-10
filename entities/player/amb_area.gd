extends Area3D

var leaves : Array
var bushes : Array


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass

func _on_body_entered(body):
	#if body.has_method("ak_event_post"):
		#body.ak_event_post()
		#print("should be calling method")
	#print(body.name)
	#print(body.global_position)
	Wwise.register_game_obj(body, body.name)
	Wwise.set_3d_position(body, body.global_transform)

	if body.get_parent().is_in_group("leaves"):
		print("LEAVES DETECTED")
		body.ak_register()
		leaves.append(body)
		print(leaves)
		body.ak_event_post("play_x_debug_continuous_sound")# play_env_leaves_rustling
	if body.get_parent().is_in_group("bush"):
		print("BUSH DETECTED")
		body.ak_register()
		body.ak_event_post("play_x_debug_continuous_sound")# play_env_bush_rustling
		
func _on_body_exited(body):
	leaves.erase(body)
	print(leaves)
	body.ak_stop_event()
	body.ak_unregister()
	
