extends Area3D


var rng := RandomNumberGenerator.new()

# Wind objects variables
var child_trees: Node
var leaves: Array
var leaves_loc: Array[Transform3D]
var child_bushes: Node
var bushes: Array
var bushes_loc: Array[Transform3D]

#var child_bird

# For Wwise callbacks
var cookie_wrapper := CookieWrapper.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	child_trees = find_child("Trees")
	child_bushes = find_child("Bushes")
	cookie_wrapper.cookie = Callable(_event_callback)
	Wwise.register_game_obj(self, get_name()) # register game object for wind gust
	Wwise.register_game_obj(child_trees, "Trees") # register respective game object
	Wwise.register_game_obj(child_bushes, "Bushes")
	#Wwise.register_game_obj(child_bird, "Bird")
	play_windgust()
	#play_animal()


#func _process(delta):
	#Wwise.set_3d_position(self, self.global_transform)
	#print(Wwise.get_rtpc_value("wind_intensity", self))


func play_windgust():
	var random := rng.randf_range(0.0, 10.0)
	await get_tree().create_timer(random).timeout
	Wwise.post_event_callback("play_wind_gust", AkUtils.AK_END_OF_EVENT, self, cookie_wrapper)


func play_animal():
	#var random_float = rng.randf_range(0.0, 30.0)
	#await get_tree().create_timer(random_float).timeout
	#var random_int = rng.randi_range(0, (leaves.size() - 1))
	#if random_int != 0:
		#Wwise.post_event("play_bird_chirp", child_bird) # a one shot bird sound from a random container
		#Wwise.set_3d_position(child_bird, leaves_loc[random_int])
	#play_animal()
	pass


func _event_callback(_data):
	# Callbacks are done from the sound engine's main thread. 
	# Gather all the information you need and return immediately.
	Thread.set_thread_safety_checks_enabled(false)
	play_windgust()


func _on_body_entered(body: Node3D):
	if body.get_parent().is_in_group("leaves"):
		on_object_entered("play_treeLeaves_rustling", child_trees, leaves, leaves_loc, "tree_amount", body)
	if body.get_parent().is_in_group("bush"):
		on_object_entered("event_name", child_bushes, bushes, bushes_loc, "bush_amount", body)


func on_object_entered(play_event_name: String, child_object: Node3D, objects_array: Array, objects_location_array: Array[Transform3D], rtpc_amount: String, body: Node3D):
	objects_array.append(body) # add object to respective array
	Wwise.set_rtpc_value(rtpc_amount, objects_array.size(), child_object)
	objects_location_array.append(body.global_transform) # add position of object to respective array
	Wwise.set_multiple_positions_3d(child_object, objects_location_array, objects_array.size(), AkUtils.TYPE_MULTI_DIRECTIONS) # set 3d positions with the afformentioned arrays
	if objects_array.size() == 1:
		Wwise.post_event(play_event_name, child_object)


func _on_body_exited(body: Node3D):
	if body.get_parent().is_in_group("leaves"):
		on_object_exited("stop_treeLeaves_rustling", child_trees, leaves, leaves_loc, "tree_amount", body)
	if body.get_parent().is_in_group("bush"):
		on_object_exited("event_name", child_bushes, bushes, bushes_loc, "bush_amount", body)


func on_object_exited(stop_event_name: String, child_object: Node3D, objects_array: Array, objects_location_array: Array[Transform3D], rtpc_amount: String, body: Node3D):
	var location = objects_array.find(body) # creating location variable to remove the location from the location array
	if objects_array.size() == 1: # if before removing the body from the arrays there's only 1 item left we know it should play the stop event
		Wwise.post_event(stop_event_name, child_object)
	if objects_array.size() != 1: # this will make sure the 3d position isn't set to an empty location array (so the stop event can play in full with fade and all)
		Wwise.set_multiple_positions_3d(child_object, objects_location_array, objects_array.size(), AkUtils.TYPE_MULTI_DIRECTIONS)
	objects_location_array.remove_at(location) # removes the 3d position at the location of the exited body 
	objects_array.erase(body) # removes the body from the array
	Wwise.set_rtpc_value(rtpc_amount, objects_array.size(), child_object)
