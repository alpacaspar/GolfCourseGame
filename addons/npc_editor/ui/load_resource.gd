@tool
class_name ResourceLoadingHandler
extends VBoxContainer


@export var thing_parent: Control
@export var save_button: Button
@export var load_button: Button

var node: EditorResourcePicker
var value: Resource:
	get:
		return node.edited_resource


func _set_value():
	node = EditorResourcePicker.new()
	node.size_flags_horizontal = 3
	thing_parent.add_child(node)

	save_button.pressed.connect(self._save)
	load_button.pressed.connect(self._load)

	node.resource_changed.connect(self.test)


func _save():
	node.save()

	
func _load():
	pass


func test(_value = 0):
	print(node.edited_resource)