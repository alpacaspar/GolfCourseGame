@tool
class_name SequenceNodeEditor
extends VBoxContainer


@export var add_node_button: Button

@export var graph_editor: GraphEdit
@export var node_prefab: PackedScene

@export var context_menu: Control

var nodes := []


func on_ready():
	add_node_button.pressed.connect(_add_node)

	graph_editor.connection_request.connect(_make_connection)
	graph_editor.disconnection_request.connect(_remove_connection)


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
	graph_editor.add_child(node)
	node.on_ready()

	node.position = graph_editor.get_local_mouse_position()

	nodes.append(node)
	context_menu.visible = false


func _make_connection(from_node: StringName, from_port: int, to_node: StringName, to_port: int):
	graph_editor.connect_node(from_node, from_port, to_node, to_port)


func _remove_connection(from_node: StringName, from_port: int, to_node: StringName, to_port: int):
	graph_editor.disconnect_node(from_node, from_port, to_node, to_port)


func _delete_node(nodes: Array[StringName]):
	# nodes.erase(node)
	# node.queue_free()
	pass
