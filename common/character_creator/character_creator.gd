extends Control


@export_subgroup("Picker")
@export var eyes_option_picker: NPCCustomizerGallery
@export var eyebrows_option_picker: NPCCustomizerGallery
@export var noses_option_picker: NPCCustomizerGallery
@export var nose_icons: Array[Texture]
@export var ears_option_picker: NPCCustomizerGallery
@export var ear_icons: Array[Texture]
@export var mouths_option_picker: NPCCustomizerGallery
@export var hair_option_picker: NPCCustomizerGallery
@export var hair_icons: Array[Texture]
@export var accessories_option_picker: NPCCustomizerGallery
@export var shirt_option_picker: NPCCustomizerGallery
@export var pants_option_picker: NPCCustomizerGallery

@export var skin_color_option_picker: NPCCustomizerPicker
@export var hair_color_option_picker: NPCCustomizerPicker
@export var shirt_color_option_picker: NPCCustomizerPicker
@export var pants_color_option_picker: NPCCustomizerPicker

@export var name_field: LineEdit

@export_subgroup("Offset Sliders")
@export var eye_offset_slider: Slider
@export var eyebrow_offset_slider: Slider
@export var mouth_offset_slider: Slider
@export var mouth_size_slider: Slider

@export_subgroup("Preview Stuff")
@export var preview: TextureRect
@export var zoom_slider: Slider
@export var rotation_slider: Slider
@export var rotation_box: SpinBox

@export_subgroup("Windows")
@export var window_button_group: ButtonGroup
@export var tab_group: TabContainer

var edited_resource: NPCResource
var current_path: String

var has_error: bool = false

var preview_scene: Node 


func _ready():
	preview_scene = preload("res://addons/npc_editor/preview_scene.tscn").instantiate()
	add_child(preview_scene)
	preview_scene.make_ready()
	
	edited_resource = NPCResource.new()

	preview_scene.callback = Callable(_set_preview)
	
	rotation_slider.value_changed.connect(_set_rotation_value)
	rotation_box.value_changed.connect(_set_rotation_value)

	rotation_slider.value_changed.connect(preview_scene._set_rotation)
	zoom_slider.value_changed.connect(preview_scene._set_zoom)

	eye_offset_slider.value_changed.connect(_update_character)
	eyebrow_offset_slider.value_changed.connect(_update_character)
	mouth_offset_slider.value_changed.connect(_update_character)
	mouth_size_slider.value_changed.connect(_update_character)

	window_button_group.pressed.connect(_open_window)

	await _set_color_button_connections(CharacterFactory.skin_colors, skin_color_option_picker)
	await _set_color_button_connections(CharacterFactory.hair_colors, hair_color_option_picker)
	await _set_color_button_connections(CharacterFactory.shirt_colors, shirt_color_option_picker)
	await _set_color_button_connections(CharacterFactory.pants_colors, pants_color_option_picker)

	await _set_head_button_connections(nose_icons, CharacterFactory.nose_meshes, noses_option_picker)
	await _set_head_button_connections(ear_icons, CharacterFactory.ear_meshes, ears_option_picker)
	await _set_head_button_connections(hair_icons, CharacterFactory.hair_meshes, hair_option_picker)

	await _set_face_button_connections(CharacterFactory.eye_textures, eyes_option_picker)
	await _set_face_button_connections(CharacterFactory.mouth_textures, mouths_option_picker)
	await _set_face_button_connections(CharacterFactory.eyebrow_textures, eyebrows_option_picker)

	await _set_body_button_connections(CharacterFactory.shirt_datas, shirt_option_picker)
	await _set_body_button_connections(CharacterFactory.pants_datas, pants_option_picker)

	_update_character()


func _process(delta):
	preview_scene.on_process(delta)


# Set all data in the "edited_resource" first, then give it to the preview spawner
func _update_character(_value = 0):
	edited_resource.name = name_field.text
	
	edited_resource.eye_index = eyes_option_picker.get_current_index()
	edited_resource.eyebrow_index = eyebrows_option_picker.get_current_index()
	edited_resource.mouth_index = mouths_option_picker.get_current_index()
	
	edited_resource.nose_index = noses_option_picker.get_current_index()
	edited_resource.ear_index = ears_option_picker.get_current_index()
	edited_resource.hair_index = hair_option_picker.get_current_index()

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

	preview_scene._edit_character(edited_resource)


func _set_preview(_texture):
	preview.texture = _texture


func _open_window(_value):
	var index = _get_current_index()
	tab_group.current_tab = index


func _set_color_button_connections(collection, picker: NPCCustomizerPicker):
	for color in collection:
		var image = load("res://addons/npc_editor/ui/solid_white.png").duplicate()
		image.fill(color)
		picker.add_button(ImageTexture.create_from_image(image), _update_character)


func _set_head_button_connections(icon_collection, collection, picker: NPCCustomizerGallery):
	var i := 0
	for option in collection:
		picker.add_button(icon_collection[i], _update_character)
		i += 1


func _set_face_button_connections(collection, picker: NPCCustomizerGallery):
	for option in collection.get_layers() - 1:
		var texture = ImageTexture.create_from_image(collection.get_layer_data(option))
		picker.add_button(texture, _update_character)


func _set_body_button_connections(collection, picker: NPCCustomizerGallery):
	for option in collection:
		picker.add_button(option.icon, _update_character)


func _set_rotation_value(_value):
	rotation_slider.value = _value
	rotation_box.value = _value


func _get_current_index() -> int:
	for button in window_button_group.get_buttons():
		if button.button_pressed:
			return window_button_group.get_buttons().find(button)
	
	return 0
