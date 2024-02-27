@tool
class_name ResourceLoadingHandler
extends VBoxContainer


@export var thing_parent: Control

var node: EditorResourcePicker
var value: Resource:
	get:
		return node.edited_resource


func _set_value():
	node = EditorResourcePicker.new()
	node.size_flags_horizontal = 3
	thing_parent.add_child(node)
