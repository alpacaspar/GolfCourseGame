@tool
class_name TimelineFunctionality
extends Container


@export var block_parent: Control

@export var sequence_block_prefab: PackedScene
@export var filler_block_prefab: PackedScene

var sequence_buttons: Array[SequenceBlock] = []
var filler_buttons: Array[Button] = []

var time_since_last_click: float
var range_for_double_click: bool


func on_ready():
	for child in block_parent.get_children():
		child.free()

	var filler = filler_block_prefab.instantiate()
	block_parent.add_child(filler)
	filler.pressed.connect(_check_for_double_click)

	filler_buttons.append(filler)


func on_process(delta):
	time_since_last_click += delta

	for block in sequence_buttons:
		block.on_process(delta)


func _add_block():
	var filler = filler_block_prefab.instantiate()
	block_parent.add_child(filler)
	filler.pressed.connect(_check_for_double_click)

	filler_buttons.append(filler)

	for button in filler_buttons:
		print("Button")


func _check_for_double_click():
	if time_since_last_click > .2:
		range_for_double_click = false

	var x_in_bounds = get_local_mouse_position().x > 0 and get_local_mouse_position().x < size.x
	var y_in_bounds = get_local_mouse_position().y > 0 and get_local_mouse_position().y < size.y
	if !x_in_bounds or !y_in_bounds:
		return

	if range_for_double_click:
		range_for_double_click = false
		_add_block()
		print("Clicked!")
	else:
		range_for_double_click = true
		time_since_last_click = 0
