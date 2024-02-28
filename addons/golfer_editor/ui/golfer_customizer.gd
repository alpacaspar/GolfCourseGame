@tool
class_name GolferCustomizer
extends Panel


@export var golfer_resource: ResourceLoadingHandler
@export var npc_resource: ResourceLoadingHandler

@export var level_field: SpinBox
@export var class_dropdown: OptionButton

@export var power_label: Label
@export var stamina_label: Label

@export var error_display: Label
@export var error_icon: TextureRect

@export var load_button: Button
@export var save_button: Button
@export var save_as_button: Button

var edited_resource: GolferResource
var current_path: String

var has_error: bool = false


func _ready():
	golfer_resource._set_value()
	npc_resource._set_value()


func _process(delta):
	pass


func _load():
	var _resource = npc_resource.value
	
	current_path = _resource.resource_path
	edited_resource = _resource.duplicate()


func _save():
	edited_resource.resource_name = edited_resource.name
	var result = ResourceSaver.save(edited_resource, current_path)
	if result != OK:
		print(result)
	else:
		print("Successfully saved")


func _save_as():
	edited_resource.resource_name = edited_resource.name
	if FileAccess.file_exists("res://common/npc_resources/{str}.tres".format({"str": edited_resource.name.to_snake_case()})):
		print("FILE ALREADY EXISTS")
		return

	var result = ResourceSaver.save(edited_resource, "res://common/npc_resources/{str}.tres".format({"str": edited_resource.name.to_snake_case()}))
	if result != OK:
		print(result)
	else:
		print("Successfully saved")
