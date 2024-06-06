@tool
class_name NPCDock
extends Control
## The code behind the UI, that makes sure all parts of the tool work as it should.
## Handles loading, saving, updating and setting data.
##
## This script works together with other scripts;
##
## npc_editor (Handles Editor code and running it)
## npc_resource (The resource for the NPC)
## preview_spawner (Shows the preview character and handles Icons)
## character_factory (Spawns a character based on the NPCResource it is given)
##
## resource_loader (Loads a resource for loading and resaving)
## npc_customizer_picker (Allows a single option from a list)
## npc_customizer_option (The single option from the npc_customizer_picker list)


@export var npc_resource: ResourceLoadingHandler

@export_subgroup("Picker")
@export var eyes_option_picker: NPCCustomizerPicker
@export var eyebrows_option_picker: NPCCustomizerPicker
@export var noses_option_picker: NPCCustomizerPicker
@export var ears_option_picker: NPCCustomizerPicker
@export var mouths_option_picker: NPCCustomizerPicker
@export var hair_option_picker: NPCCustomizerPicker
@export var accessories_option_picker: NPCCustomizerPicker
@export var shirt_option_picker: NPCCustomizerPicker
@export var pants_option_picker: NPCCustomizerPicker

@export var skin_color_option_picker: NPCCustomizerPicker
@export var hair_color_option_picker: NPCCustomizerPicker
@export var shirt_color_option_picker: NPCCustomizerPicker
@export var pants_color_option_picker: NPCCustomizerPicker

@export_subgroup("Offset Sliders")
@export var eye_offset_slider: Slider
@export var eyebrow_offset_slider: Slider
@export var mouth_offset_slider: Slider
@export var mouth_size_slider: Slider

@export_subgroup("References")
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
var preview_scene: PreviewSpawner

var has_error: bool = false


func make_ready(_preview_scene: Node):
	npc_resource.set_value()
	edited_resource = NPCResource.new()

	preview_scene = _preview_scene as PreviewSpawner
	preview_scene.callback = Callable(_set_preview)
	
	rotation_slider.value_changed.connect(_set_rotation_value)
	rotation_box.value_changed.connect(_set_rotation_value)

	load_button.pressed.connect(_load)
	save_button.pressed.connect(_save)
	save_as_button.pressed.connect(_save_as)

	update_preview_callback = Callable(preview_scene._edit_character)
	rotation_slider.value_changed.connect(preview_scene._set_rotation)
	zoom_slider.value_changed.connect(preview_scene.set_zoom)

	eye_offset_slider.value_changed.connect(_update_character)
	eyebrow_offset_slider.value_changed.connect(_update_character)
	mouth_offset_slider.value_changed.connect(_update_character)
	mouth_size_slider.value_changed.connect(_update_character)

	name_field.text_changed.connect(_update_character)

	await _set_color_button_connections(CharacterFactory.skin_colors, skin_color_option_picker)
	await _set_color_button_connections(CharacterFactory.hair_colors, hair_color_option_picker)
	await _set_color_button_connections(CharacterFactory.shirt_colors, shirt_color_option_picker)
	await _set_color_button_connections(CharacterFactory.pants_colors, pants_color_option_picker)

	await _set_head_button_connections(preview_scene, CharacterFactory.nose_meshes, false, noses_option_picker)
	await _set_head_button_connections(preview_scene, CharacterFactory.ear_meshes, false, ears_option_picker)
	await _set_head_button_connections(preview_scene, CharacterFactory.hair_meshes, true, hair_option_picker)

	await _set_face_button_connections(CharacterFactory.eye_textures, eyes_option_picker)
	await _set_face_button_connections(CharacterFactory.mouth_textures, mouths_option_picker)
	await _set_face_button_connections(CharacterFactory.eyebrow_textures, eyebrows_option_picker)

	await _set_body_button_connections(preview_scene, CharacterFactory.shirt_datas, shirt_option_picker)
	await _set_body_button_connections(preview_scene, CharacterFactory.pants_datas, pants_option_picker)

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
	edited_resource.mouth_index = mouths_option_picker.get_current_index()
	
	edited_resource.nose_index = noses_option_picker.get_current_index()
	edited_resource.ear_index = ears_option_picker.get_current_index()
	edited_resource.hair_index = hair_option_picker.get_current_index()

	edited_resource.accessory_index = accessories_option_picker.get_current_index()
	edited_resource.shirt_index = shirt_option_picker.get_current_index()
	edited_resource.pants_index = pants_option_picker.get_current_index()

	edited_resource.hair_color_index = hair_color_option_picker.get_current_index()
	edited_resource.skin_color_index = skin_color_option_picker.get_current_index()
	edited_resource.shirt_color_index = shirt_color_option_picker.get_current_index()
	edited_resource.pants_color_index = pants_color_option_picker.get_current_index()

	edited_resource.eye_offset = eye_offset_slider.value
	edited_resource.eyebrow_offset = eyebrow_offset_slider.value
	edited_resource.mouth_offset = mouth_offset_slider.value
	edited_resource.mouth_size = mouth_size_slider.value

	edited_resource.icon = await preview_scene.create_icon(edited_resource)

	update_preview_callback.call(edited_resource)


# Update all UI to display the current options
func _load():
	var _resource = npc_resource.value

	eyes_option_picker.set_button_index(_resource.eye_index)
	eyebrows_option_picker.set_button_index(_resource.eyebrow_index)
	mouths_option_picker.set_button_index(_resource.mouth_index)
	
	noses_option_picker.set_button_index(_resource.nose_index)
	ears_option_picker.set_button_index(_resource.ear_index)
	hair_option_picker.set_button_index(_resource.hair_index)

	accessories_option_picker.set_button_index(_resource.accessory_index)
	shirt_option_picker.set_button_index(_resource.shirt_index)
	pants_option_picker.set_button_index(_resource.pants_index)

	hair_color_option_picker.set_button_index(_resource.hair_color_index)
	skin_color_option_picker.set_button_index(_resource.skin_color_index)
	shirt_color_option_picker.set_button_index(_resource.shirt_color_index)
	pants_color_option_picker.set_button_index(_resource.pants_color_index)

	eye_offset_slider.value = _resource.eye_offset
	eyebrow_offset_slider.value = _resource.eyebrow_offset
	mouth_offset_slider.value = _resource.mouth_offset
	mouth_size_slider.value = _resource.mouth_size

	name_field.text = _resource.name
	current_path = _resource.resource_path
	edited_resource = _resource.duplicate()

	_update_character()


func _save():
	var resource: NPCResource = load(current_path) as NPCResource
	_overwrite(resource, edited_resource)
	resource.resource_name = edited_resource.name


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


func _set_preview(_texture: Texture):
	preview.texture = _texture


func _set_color_button_connections(collection: Array, picker: NPCCustomizerPicker):
	for color: Color in collection:
		var image: Image = load("res://addons/npc_editor/ui/solid_white.png").duplicate()
		image.fill(color)
		picker.add_button(ImageTexture.create_from_image(image), _update_character)


func _set_head_button_connections(preview_scene: Node, collection: Array, rotate: bool, picker: NPCCustomizerPicker):
	for option: Mesh in collection:
		#var texture = await preview_scene.create_button_icon(option, rotate)
		picker.add_button(null, _update_character)


func _set_face_button_connections(collection: CompressedTexture2DArray, picker: NPCCustomizerPicker):
	for option: int in collection.get_layers():
		var texture = await ImageTexture.create_from_image(collection.get_layer_data(option))
		picker.add_button(texture, _update_character)


func _set_body_button_connections(preview_scene: Node, collection: Array, picker: NPCCustomizerPicker):
	for option: Resource in collection:
		#var texture = await ImageTexture.create_from_image(collection.get_layer_data(option))
		picker.add_button(null, _update_character)


func _set_rotation_value(_value: float):
	rotation_slider.value = _value
	rotation_box.value = _value


func _overwrite(to_overwrite: NPCResource, overwriter: NPCResource):
	to_overwrite.name = overwriter.name

	to_overwrite.eye_index = overwriter.eye_index
	to_overwrite.eyebrow_index = overwriter.eyebrow_index
	to_overwrite.nose_index = overwriter.nose_index
	to_overwrite.ear_index = overwriter.ear_index
	to_overwrite.mouth_index = overwriter.mouth_index
	to_overwrite.hair_index = overwriter.hair_index
	to_overwrite.accessory_index = overwriter.accessory_index
	to_overwrite.shirt_index = overwriter.shirt_index
	to_overwrite.pants_index = overwriter.pants_index

	to_overwrite.hair_color_index = overwriter.hair_color_index
	to_overwrite.skin_color_index = overwriter.skin_color_index
	to_overwrite.shirt_color_index = overwriter.shirt_color_index
	to_overwrite.pants_color_index = overwriter.pants_color_index

	to_overwrite.eye_offset = overwriter.eye_offset
	to_overwrite.eyebrow_offset = overwriter.eyebrow_offset
	to_overwrite.mouth_offset = overwriter.mouth_offset
	to_overwrite.mouth_size = overwriter.mouth_size
	to_overwrite.icon = overwriter.icon
