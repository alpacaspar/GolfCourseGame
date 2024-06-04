extends Control


@export_group("Face Options")
@export_subgroup("Face Picker")
@export var eyes_option_picker: CreatorGallery
@export var eyebrows_option_picker: CreatorGallery
@export var noses_option_picker: CreatorGallery
@export var ears_option_picker: CreatorGallery
@export var mouths_option_picker: CreatorGallery
@export var hair_option_picker: CreatorGallery

@export var eyeshadow_option_picker: CreatorGallery
@export var eyeliner_option_picker: CreatorGallery
@export var blush_option_picker: CreatorGallery

@export var glasses_option_picker: CreatorGallery

@export var mustaches_option_picker: CreatorGallery
@export var beards_option_picker: CreatorGallery

@export var piercings_option_picker: CreatorGallery

@export_subgroup("Color Picker")
@export var skin_color_tracker: IndexTracker
@export var skin_color_option_pickers: Array[CreatorColorPicker]
@export var eyebrow_color_option_picker: CreatorColorPicker
@export var hair_color_option_picker: CreatorColorPicker
@export var mustache_color_option_picker: CreatorColorPicker
@export var beard_color_option_picker: CreatorColorPicker

@export var lip_color_option_picker: CreatorColorPicker
@export var eyeshadow_color_option_picker: CreatorColorPicker
@export var eyeliner_color_option_picker: CreatorColorPicker
@export var blush_color_option_picker: CreatorColorPicker

@export var glasses_color_option_picker: CreatorColorPicker

@export_subgroup("Finetune Buttons")
@export var eye_buttons: FinetineButtons
@export var eye_range: FinetuneRanges
@export var eyebrow_buttons: FinetineButtons
@export var eyebrow_range: FinetuneRanges
@export var mouth_buttons: FinetineButtons
@export var mouth_range: FinetuneRanges
@export var glasses_buttons: FinetineButtons
@export var glasses_range: FinetuneRanges
@export var mustache_buttons: FinetineButtons
@export var mustache_range: FinetuneRanges

@export_group("Body Options")
@export_subgroup("Body Pickers")
@export var shirt_option_picker: CreatorGallery
@export var pants_option_picker: CreatorGallery
@export var sock_option_picker: CreatorGallery
@export var shoes_option_picker: CreatorGallery
@export var belt_option_picker: CreatorGallery
@export var wrists_option_picker: CreatorGallery

@export_subgroup("Color Pickers")
@export var shirt_color_option_picker: CreatorColorPicker
@export var pants_color_option_picker: CreatorColorPicker
@export var sock_color_option_picker: CreatorColorPicker
@export var shoes_color_option_picker: CreatorColorPicker
@export var belt_color_option_picker: CreatorColorPicker

@export_group("Extra Options")
@export var name_field: LineEdit

@export_group("Icons")
@export var hair_icons: Array[Texture] = []
@export var nose_icons: Array[Texture] = []
@export var ear_icons: Array[Texture] = []
@export var beard_icons: Array[Texture] = []
@export var piercing_icons: Array[Texture] = []

@export_group("Preview Stuff")
@export var preview: TextureRect
@export var zoom_slider: ScrollBar
@export var rotation_slider: ScrollBar

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

	rotation_slider.value_changed.connect(preview_scene._set_rotation)
	zoom_slider.value_changed.connect(preview_scene._set_zoom)

	# Colors
	for picker in skin_color_option_pickers:
		await _set_color_button_connections(CharacterFactory.skin_colors, picker)
	await _set_color_button_connections(CharacterFactory.hair_colors, hair_color_option_picker)
	await _set_color_button_connections(CharacterFactory.hair_colors, eyebrow_color_option_picker)
	await _set_color_button_connections(CharacterFactory.hair_colors, mustache_color_option_picker)
	await _set_color_button_connections(CharacterFactory.hair_colors, beard_color_option_picker)
	await _set_color_button_connections(CharacterFactory.lip_colors, lip_color_option_picker)
	await _set_color_button_connections(CharacterFactory.eyeshadow_colors, eyeshadow_color_option_picker)
	await _set_color_button_connections(CharacterFactory.eyeliner_colors, eyeliner_color_option_picker)
	await _set_color_button_connections(CharacterFactory.blush_colors, blush_color_option_picker)
	await _set_color_button_connections(CharacterFactory.glasses_colors, glasses_color_option_picker)
	
	await _set_color_button_connections(CharacterFactory.shirt_colors, shirt_color_option_picker)
	await _set_color_button_connections(CharacterFactory.pants_colors, pants_color_option_picker)
	await _set_color_button_connections(CharacterFactory.shirt_colors, sock_color_option_picker)
	await _set_color_button_connections(CharacterFactory.shirt_colors, shoes_color_option_picker)
	await _set_color_button_connections(CharacterFactory.belt_colors, belt_color_option_picker)

	# External Icons
	await _set_external_icon_button_connections(nose_icons, CharacterFactory.nose_meshes, noses_option_picker)
	await _set_external_icon_button_connections(ear_icons, CharacterFactory.ear_meshes, ears_option_picker)
	await _set_external_icon_button_connections(hair_icons, CharacterFactory.hair_meshes, hair_option_picker)
	await _set_external_icon_button_connections(CharacterFactory.beard_textures, CharacterFactory.beard_textures, beards_option_picker)
	await _set_external_icon_button_connections(piercing_icons, CharacterFactory.earring_meshes, piercings_option_picker)

	# Build in icons
	await _set_texture_button_connections(CharacterFactory.eye_textures, eyes_option_picker)
	await _set_texture_button_connections(CharacterFactory.eyebrow_textures, eyebrows_option_picker)
	await _set_texture_button_connections(CharacterFactory.mouth_textures, mouths_option_picker)

	await _set_single_texture_button_connections(CharacterFactory.eyeshadow_textures, eyeshadow_option_picker)
	await _set_single_texture_button_connections(CharacterFactory.eyeliner_textures, eyeliner_option_picker)
	# await _set_texture_button_connections(CharacterFactory.glasses_textures, glasses_option_picker)
	# await _set_texture_button_connections(CharacterFactory.mustache_textures, mustaches_option_picker)
	await _set_external_icon_button_connections(CharacterFactory.blush_textures, CharacterFactory.blush_textures, blush_option_picker)

	# Clothing data option picker
	await _set_body_button_connections(CharacterFactory.shirt_datas, shirt_option_picker)
	await _set_body_button_connections(CharacterFactory.pants_datas, pants_option_picker)
	await _set_body_button_connections(CharacterFactory.sock_datas, sock_option_picker)
	await _set_body_button_connections(CharacterFactory.shoes_datas, shoes_option_picker)
	await _set_body_button_connections(CharacterFactory.belt_datas, belt_option_picker)
	await _set_body_button_connections(CharacterFactory.wrists_datas, wrists_option_picker)

	# Offset Buttons
	eye_buttons.set_values(eye_range)
	eyebrow_buttons.set_values(eyebrow_range)
	mouth_buttons.set_values(mouth_range)
	glasses_buttons.set_values(glasses_range)
	mustache_buttons.set_values(mustache_range)

	_update_character()


func _process(delta):
	preview_scene.on_process(delta)


# Set all data in the "edited_resource" first, then give it to the preview spawner
func _update_character(_value = 0):
	edited_resource.name = name_field.text
	
	# Face stuff
	edited_resource.eye_index = eyes_option_picker.get_current_index()
	edited_resource.eyebrow_index = eyebrows_option_picker.get_current_index()
	edited_resource.mouth_index = mouths_option_picker.get_current_index()
	edited_resource.nose_index = noses_option_picker.get_current_index()
	edited_resource.ear_index = ears_option_picker.get_current_index()
	edited_resource.hair_index = hair_option_picker.get_current_index()

	edited_resource.eyeshadow_index = eyeshadow_option_picker.get_current_index()
	edited_resource.eyeliner_index = eyeliner_option_picker.get_current_index()
	edited_resource.blush_index = blush_option_picker.get_current_index()
	edited_resource.glasses_index = glasses_option_picker.get_current_index()
	edited_resource.piercing_index = piercings_option_picker.get_current_index()

	edited_resource.mustache_index = mustaches_option_picker.get_current_index()
	edited_resource.beard_index = beards_option_picker.get_current_index()

	edited_resource.skin_color_index = skin_color_tracker.index
	edited_resource.eyebrow_color_index = eyebrow_color_option_picker.get_current_index()
	edited_resource.hair_color_index = hair_color_option_picker.get_current_index()
	edited_resource.mustache_color_index = mustache_color_option_picker.get_current_index()
	edited_resource.beard_color_index = beard_color_option_picker.get_current_index()

	edited_resource.lip_color_index = lip_color_option_picker.get_current_index()
	edited_resource.eyeshadow_color_index = eyeshadow_color_option_picker.get_current_index()
	edited_resource.eyeliner_color_index = eyeliner_color_option_picker.get_current_index()
	edited_resource.blush_color_index = blush_color_option_picker.get_current_index()
	edited_resource.glasses_color_index = glasses_color_option_picker.get_current_index()

	# Body Stuff
	edited_resource.shirt_index = shirt_option_picker.get_current_index()
	edited_resource.pants_index = pants_option_picker.get_current_index()
	edited_resource.sock_index = sock_option_picker.get_current_index()
	edited_resource.shoe_index = shoes_option_picker.get_current_index()
	edited_resource.belt_index = belt_option_picker.get_current_index()
	edited_resource.wrist_index = wrists_option_picker.get_current_index()

	edited_resource.shirt_color_index = shirt_color_option_picker.get_current_index()
	edited_resource.pants_color_index = pants_color_option_picker.get_current_index()
	edited_resource.sock_color_index = sock_color_option_picker.get_current_index()
	edited_resource.shoes_color_index = shoes_color_option_picker.get_current_index()
	edited_resource.belt_color_index = belt_color_option_picker.get_current_index()

	# Offset Stuff
	edited_resource.eye_values = eye_buttons.get_values()
	edited_resource.eyebrow_values = eyebrow_buttons.get_values()
	edited_resource.mouth_values = mouth_buttons.get_values()
	edited_resource.glasses_values = glasses_buttons.get_values()
	edited_resource.mustache_values = mustache_buttons.get_values()

	preview_scene._edit_character(edited_resource)


func _set_preview(_texture):
	preview.texture = _texture


func _set_color_button_connections(collection, picker: CreatorColorPicker):
	for color in collection:
		picker.add_button(color, _update_character)


func _set_external_icon_button_connections(icon_collection, collection, picker: CreatorGallery):
	var i := 0
	for option in collection:
		var texture = icon_collection[i] if icon_collection.size() > i else null
		picker.add_button(texture, _update_character)
		i += 1


func _set_texture_button_connections(collection, picker: CreatorGallery):
	for option in collection.get_layers() - 1:
		var texture = ImageTexture.create_from_image(collection.get_layer_data(option))
		picker.add_button(texture, _update_character)


func _set_single_texture_button_connections(collection, picker: CreatorGallery):
	for option in collection:
		var texture = ImageTexture.create_from_image(option.get_layer_data(0))
		picker.add_button(texture, _update_character)


func _set_body_button_connections(collection, picker: CreatorGallery):
	for option in collection:
		picker.add_button(option.icon, _update_character)


func _set_rotation_value(_value):
	rotation_slider.value = _value
