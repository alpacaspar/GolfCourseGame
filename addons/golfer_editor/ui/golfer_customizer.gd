@tool
class_name GolferCustomizer
extends Panel


var active: bool = false

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
	golfer_resource.set_value()
	npc_resource.set_value()

	npc_resource.value_changed.connect(_update_resource)
	level_field.value_changed.connect(_update_resource)
	class_dropdown.value_changed.connect(_update_resource)

	save_button.pressed.connect(_save)
	load_button.pressed.connect(_load)
	save_as_button.pressed.connect(_save_as)

	active = true


func _process(delta):
	if not Engine.is_editor_hint():
		return

	if not active:
		return

	if golfer_resource.value == null:
		save_button.disabled = true
		load_button.disabled = true
	else:
		save_button.disabled = false
		load_button.disabled = false

	_check_for_errors()
	if has_error:
		save_button.disabled = true
		save_as_button.disabled = true
	else:
		save_as_button.disabled = false


func _update_resource(_value):
	print("AAAAAAAAAAAA")
	
	edited_resource.set_resource(class_dropdown.get_item_text(class_dropdown.get_selected_id()),
		level_field.value,
		npc_resource.value)


func _load():
	var _resource = golfer_resource.value
	
	class_dropdown.select(class_dropdown.get_item_id(()))
	
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


func _check_for_errors():
	var result := ""

	if npc_resource.value == null:
		result += "NPC Resource cannot be empty"

	if result == "":
		result = "No Errors Found."
		error_display.label_settings.font_color = Color(1.0, 1.0, 1.0, 1.0)
		error_icon.texture = load("res://addons/npc_editor/ui/Info_icon.png")
		has_error = false
	else:
		error_display.label_settings.font_color = Color(1.0, 0.3, 0.3, 1.0)
		error_icon.texture = load("res://addons/npc_editor/ui/Error_icon.png")
		has_error = true

	error_display.text = result
