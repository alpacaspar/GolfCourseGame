@tool
class_name TimelineFunctionality
extends Container


var active: bool = false


func _ready():
	active = true


func _process(delta):
	if not active:
		return
	
	var x_in_bounds = get_local_mouse_position().x > 0 and get_local_mouse_position().x < size.x
	var y_in_bounds = get_local_mouse_position().y > 0 and get_local_mouse_position().y < size.y
	# print(x_in_bounds and y_in_bounds)

	if _check_for_double_click(delta):
		print("Clicked!")
	
	# if Input.is_action_just_pressed("interact"):
	# 	print("Clicking")


func _add_block():
	pass


var time_since_last_click: float
var range_for_double_click: bool
func _check_for_double_click(delta) -> bool:
	time_since_last_click += delta

	if time_since_last_click > .5:
		range_for_double_click = false

	var x_in_bounds = get_local_mouse_position().x > 0 and get_local_mouse_position().x < size.x
	var y_in_bounds = get_local_mouse_position().y > 0 and get_local_mouse_position().y < size.y
	if !x_in_bounds or !y_in_bounds:
		return false

	if Input.is_mouse_button_pressed(0):
		if range_for_double_click:
			return true
		else:
			range_for_double_click = true
			return false
	
	return false


func _exit_tree():
	active = false