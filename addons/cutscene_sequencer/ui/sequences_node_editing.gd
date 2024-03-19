@tool
class_name SequenceNodeEditor
extends VBoxContainer


@export var add_node_button: Button

@export var node_parent: Control
@export var node_prefab: PackedScene

var nodes := []


func on_ready():
	add_node_button.pressed.connect(_add_node)


func on_process(delta):
	for node in nodes:
		node.on_process(delta)


func _add_node():
	var node = node_prefab.instantiate() as SequenceNode
	node_parent.add_child(node)
	node.on_ready()

	nodes.append(node)


func remove_node(node: Control):
	nodes.erase(node)
	node.queue_free()
