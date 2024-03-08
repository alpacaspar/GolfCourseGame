@tool
class_name ResourceLoadingHandler
extends VBoxContainer


@export var thing_parent: Control

var node: EditorResourcePicker
var value: Resource:
	get:
		return node.edited_resource
	set(value):
		node.edited_resource = value

var last_value: Resource

signal value_changed(value)


func set_value():
	node = EditorResourcePicker.new()
	node.size_flags_horizontal = node.SIZE_EXPAND_FILL
	thing_parent.add_child(node)


func _process(_delta):
	if node == null:
		return

	if value != last_value:
		value_changed.emit(value)
		last_value = value
