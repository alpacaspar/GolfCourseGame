@tool
class_name ResourceLoadingHandler
extends VBoxContainer


@export var thing_parent: Control
@export var save_button: Button
@export var load_button: Button

var value: Resource
var node


func _set_value():
	node = EditorResourcePicker.new()
	node.size_flags_horizontal = 3
	thing_parent.add_child(node)

	save_button.pressed.connect(self._save)
	load_button.pressed.connect(self._load)


func _save():
	pass

	
func _load():
	pass
