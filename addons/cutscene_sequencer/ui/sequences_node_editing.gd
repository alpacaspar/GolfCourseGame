@tool
class_name SequenceNodeEditor
extends VBoxContainer


@export var add_node_button: Button

@export var node_parent: Control
@export var node_prefab: PackedScene

@export var context_menu: Control

var nodes := []


func on_ready():
	add_node_button.pressed.connect(_add_node)


func on_process(delta):
	for node in nodes:
		node.on_process(delta)


func _input(event):
	var local_pos = get_local_mouse_position()
	var x_in_bounds = local_pos.x > 0 and local_pos.x < size.x
	var y_in_bounds = local_pos.y > 0 and local_pos.y < size.y
	if !x_in_bounds or !y_in_bounds:
		return

	if !event.is_class("InputEventMouseButton"):
		return

	var left_click = (event as InputEventMouseButton).button_index == 1
	var right_click = (event as InputEventMouseButton).button_index == 2

	if context_menu.visible == true:
		var context_local_pos = context_menu.get_local_mouse_position()
		var context_x_in_bounds = context_local_pos.x > 0 and context_local_pos.x < context_menu.size.x
		var context_y_in_bounds = context_local_pos.y > 0 and context_local_pos.y < context_menu.size.y
		if context_x_in_bounds and context_y_in_bounds:
			return

		if left_click:
			context_menu.visible = false
	else: if right_click:
		context_menu.visible = true
		context_menu.position = get_local_mouse_position()


func _add_node():
	var node = node_prefab.instantiate() as SequenceNode
	node_parent.add_child(node)
	node.on_ready()

	nodes.append(node)
	context_menu.visible = false


func remove_node(node: Control):
	nodes.erase(node)
	node.queue_free()
