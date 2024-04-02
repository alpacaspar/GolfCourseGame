@tool
class_name NPCDock
extends Control
# The code behind the UI, that makes sure all parts of the tool work as it should.
# Handles loading, saving, updating and setting data.


# This script works together with other scripts;

# npc_editor (Handles Editor code and running it)
# npc_resource (The resource for the NPC)
# preview_spawner (Shows the preview character and handles Icons)
# character_factory (Spawns a character based on the NPCResource it is given)

# resource_loader (Loads a resource for loading and resaving)
# npc_customizer_picker (Allows a single option from a list)
# npc_customizer_option (The single option from the npc_customizer_picker list)


@export var npc_resource: ResourceLoadingHandler

@export_subgroup("Picker")
@export var eyes_option_picker: NPCCustomizerPicker
@export var eyebrows_option_picker: NPCCustomizerPicker
@export var noses_option_picker: NPCCustomizerPicker
@export var ears_option_picker: NPCCustomizerPicker
@export var mouths_option_picker: NPCCustomizerPicker
@export var hair_option_picker: NPCCustomizerPicker
@export var accessories_option_picker: NPCCustomizerPicker

@export_subgroup("References")
@export var hair_color_picker: ColorPickerButton
@export var skin_color_picker: ColorPickerButton
@export var name_field: LineEdit
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


func make_ready(preview_scene):
	npc_resource.set_value()
	edited_resource = NPCResource.new()

	preview_scene.callback = Callable(_set_preview)
	
	rotation_slider.value_changed.connect(_set_rotation_value)
	rotation_box.value_changed.connect(_set_rotation_value)

	hair_color_picker.color_changed.connect(_update_character)
	skin_color_picker.color_changed.connect(_update_character)

	load_button.pressed.connect(_load)
	save_button.pressed.connect(_save)
	save_as_button.pressed.connect(_save_as)

	update_preview_callback = Callable(preview_scene._edit_character)
	rotation_slider.value_changed.connect(preview_scene._set_rotation)
	zoom_slider.value_changed.connect(preview_scene._set_zoom)

	await _set_button_connections(preview_scene, CharacterFactory.nose_meshes, false, noses_option_picker)
	await _set_button_connections(preview_scene, CharacterFactory.ear_meshes, false, ears_option_picker)
	await _set_button_connections(preview_scene, CharacterFactory.hair_meshes, true, hair_option_picker)
	await _set_button_connections(preview_scene, CharacterFactory.accessory_meshes, false, accessories_option_picker)

	await _set_face_button_connections(preview_scene, CharacterFactory.eye_textures, eyes_option_picker)
	await _set_face_button_connections(preview_scene, CharacterFactory.mouth_textures, mouths_option_picker)
	await _set_face_button_connections(preview_scene, CharacterFactory.eyebrow_textures, eyebrows_option_picker)

	_update_character()


func on_process(delta):
	if not Engine.is_editor_hint():
		return

	if self == get_tree().edited_scene_root:
		return

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


# Set all data in the "edited_resource" first, then give it to the preview spawner
func _update_character(_value = 0):
	edited_resource.name = name_field.text
	
	edited_resource.eye_index = eyes_option_picker.get_current_index()
	edited_resource.eyebrow_index = eyebrows_option_picker.get_current_index()
	edited_resource.nose_index = noses_option_picker.get_current_index()
	edited_resource.ear_index = ears_option_picker.get_current_index()
	edited_resource.mouth_index = mouths_option_picker.get_current_index()
	edited_resource.hair_index = hair_option_picker.get_current_index()
	edited_resource.accessory_index = accessories_option_picker.get_current_index()

	edited_resource.hair_color = hair_color_picker.color
	edited_resource.skin_color = skin_color_picker.color

	update_preview_callback.call(edited_resource)


# Update all UI to display the current options
func _load():
	var _resource = npc_resource.value

	eyes_option_picker.set_button_index(_resource.eye_index)
	eyebrows_option_picker.set_button_index(_resource.eyebrow_index)
	noses_option_picker.set_button_index(_resource.nose_index)
	ears_option_picker.set_button_index(_resource.ear_index)
	mouths_option_picker.set_button_index(_resource.mouth_index)
	hair_option_picker.set_button_index(_resource.hair_index)
	accessories_option_picker.set_button_index(_resource.accessory_index)

	hair_color_picker.color = _resource.hair_color
	skin_color_picker.color = _resource.skin_color

	name_field.text = _resource.name
	current_path = _resource.resource_path
	edited_resource = _resource.duplicate()


func _save():
	edited_resource.resource_name = edited_resource.name
	var result := ResourceSaver.save(edited_resource, current_path)
	if result != OK:
		print(result)
	else:
		print("Successfully saved")


func _save_as():
	edited_resource.resource_name = edited_resource.name
	if FileAccess.file_exists("res://common/npc_resources/{str}.tres".format({"str": edited_resource.name.to_snake_case()})):
		print("FILE ALREADY EXISTS")
		return

	var result := ResourceSaver.save(edited_resource, "res://common/npc_resources/{str}.tres".format({"str": edited_resource.name.to_snake_case()}))
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


func _set_button_connections(preview_scene, collection, rotate, picker: NPCCustomizerPicker):
	for option in collection:
		var texture = await preview_scene.create_button_icon(option, rotate)
		picker.add_button(texture, _update_character)


func _set_face_button_connections(preview_scene, collection, picker: NPCCustomizerPicker):
	for option in collection.get_layers():
		var texture = await ImageTexture.create_from_image(collection.get_layer_data(option))
		picker.add_button(texture, _update_character)


func _set_rotation_value(_value):
	rotation_slider.value = _value
	rotation_box.value = _value
