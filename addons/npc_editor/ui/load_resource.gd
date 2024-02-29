@tool
class_name ResourceLoadingHandler
extends VBoxContainer


@export var thing_parent: Control

var node: EditorResourcePicker
var value: Resource:
	get:
		return node.edited_resource
	set(_value):
		node.edited_resource = _value

var last_value

signal value_changed(value)


func set_value():
	node = EditorResourcePicker.new()
	node.size_flags_horizontal = 3
	thing_parent.add_child(node)


func _process(_delta):
	if node == null:
		return

	if value != last_value:
		value_changed.emit(value)
		last_value = value
