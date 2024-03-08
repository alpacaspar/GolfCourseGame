@tool
class_name NPCCustomizer
extends Panel


var active: bool = false

@export var npc_resource: ResourceLoadingHandler

@export_subgroup("Picker")
@export var eyes_option_picker: NPCCustomizerPicker
@export var noses_option_picker: NPCCustomizerPicker
@export var ears_option_picker: NPCCustomizerPicker
@export var mouths_option_picker: NPCCustomizerPicker
@export var hair_option_picker: NPCCustomizerPicker
@export var accessories_option_picker: NPCCustomizerPicker

@export_subgroup("References")
@export var name_field: LineEdit
@export var chin_slider: Slider
@export var load_button: Button
@export var save_button: Button
@export var save_as_button: Button

@export_subgroup("Preview Stuff")
@export var preview: TextureRect
@export var zoom_slider: Slider
@export var rotation_slider: Slider
@export var rotation_box: SpinBox

@export_subgroup("Error Stuff")
@export var error_display: Label
@export var error_icon: TextureRect


var update_preview_callback: Callable

var edited_resource: NPCResource
var current_path: String

var has_error: bool = false


func _ready():
	npc_resource.set_value()

	chin_slider.value_changed.connect(_update_character)

	rotation_slider.value_changed.connect(_set_rotation_value)
	rotation_box.value_changed.connect(_set_rotation_value)

	load_button.pressed.connect(_load)
	save_button.pressed.connect(_save)
	save_as_button.pressed.connect(_save_as)

	edited_resource = NPCResource.new()
	active = true


func _process(delta):
	if not Engine.is_editor_hint():
		return

	if not active:
		return

	active = false

	if npc_resource.value == null:
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


func _update_character(_value = 0):
	edited_resource.name = name_field.text
	
	edited_resource.eye_index = eyes_option_picker.get_current_index()
	edited_resource.nose_index = noses_option_picker.get_current_index()
	edited_resource.ear_index = ears_option_picker.get_current_index()
	edited_resource.mouth_index = mouths_option_picker.get_current_index()
	edited_resource.hair_index = hair_option_picker.get_current_index()
	edited_resource.accessory_index = accessories_option_picker.get_current_index()

	edited_resource.chin_value = chin_slider.value

	update_preview_callback.call(edited_resource)


func _load():
	var _resource = npc_resource.value

	eyes_option_picker.set_button_index(_resource.eye_index)
	noses_option_picker.set_button_index(_resource.nose_index)
	ears_option_picker.set_button_index(_resource.ear_index)
	mouths_option_picker.set_button_index(_resource.mouth_index)
	hair_option_picker.set_button_index(_resource.hair_index)
	accessories_option_picker.set_button_index(_resource.accessory_index)

	name_field.text = _resource.name
	chin_slider.value = _resource.chin_value
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

	if name_field.text == "":
		result += "Name cannot be empty"

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


func _set_preview(_texture):
	preview.texture = _texture


func set_pickers(preview_scene):
	await _set_button_connections(preview_scene, preview_scene.character_factory.eye_meshes, false, eyes_option_picker)
	await _set_button_connections(preview_scene, preview_scene.character_factory.nose_meshes, false, noses_option_picker)
	await _set_button_connections(preview_scene, preview_scene.character_factory.ear_meshes, false, ears_option_picker)
	await _set_button_connections(preview_scene, preview_scene.character_factory.mouth_meshes, false, mouths_option_picker)
	await _set_button_connections(preview_scene, preview_scene.character_factory.hair_meshes, true, hair_option_picker)
	await _set_button_connections(preview_scene, preview_scene.character_factory.accessory_meshes, false, accessories_option_picker)


func _set_button_connections(preview_scene, collection, rotate, picker: NPCCustomizerPicker):
	for option in collection:
		var texture = await preview_scene.create_button_icon(option, rotate)
		picker.add_button(texture, _update_character)


func _set_rotation_value(_value):
	rotation_slider.value = _value
	rotation_box.value = _value


func _exit_tree():
	active = false
