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

@export var nose_piercings_option_picker: CreatorGallery
@export var eyebrow_piercings_option_picker: CreatorGallery
@export var earrings_option_picker: CreatorGallery

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

@export_group("Extra Options")
@export var name_field: LineEdit
@export var randomize_button: Button
@export var reset_button: Button

@export_group("Icons")
@export var hair_icons: Array[Texture] = []
@export var nose_icons: Array[Texture] = []
@export var ear_icons: Array[Texture] = []
@export var beard_icons: Array[Texture] = []
@export var piercing_icons: Array[Texture] = []
@export var blush_icons: Array[Texture] = []
@export var earring_icons: Array[Texture] = []
@export var wrist_icons: Array[Texture] = []
@export var empty_icon: Texture

@export_group("Preview Stuff")
@export var preview: TextureRect
@export var zoom_slider: ScrollBar
@export var zoom_target_slider: ScrollBar
@export var rotation_slider: ScrollBar

@export var edited_resource: NPCResource

@export_group("Finish Settings")
@export var finish_button: Button
@export var scene_loader: Resource
@export var next_scenes: Array[PackedScene] = []

var preview_scene: PreviewSpawner

var current_character: Character


func _ready():
	preview_scene = preload("res://addons/npc_editor/preview_scene.tscn").instantiate() as PreviewSpawner
	add_child(preview_scene)
	
	current_character = CharacterFactory.create_character(edited_resource)
	CharacterFactory.start_character_creation(current_character)
	CharacterFactory.refresh_character(current_character)

	preview_scene.show_character(current_character)
	preview_scene.callback = Callable(_set_preview)
	
	zoom_slider.value_changed.connect(preview_scene.set_zoom)
	zoom_target_slider.value_changed.connect(preview_scene.set_zoom_target)
	rotation_slider.value_changed.connect(preview_scene._set_rotation)

	randomize_button.pressed.connect(_randomize)
	reset_button.pressed.connect(_reset)
	finish_button.pressed.connect(_finish)

	# Colors
	for picker: CreatorColorPicker in skin_color_option_pickers:
		await _set_color_button_connections(CharacterFactory.skin_colors, picker)
	
	await _set_color_button_connections(CharacterFactory.hair_colors, hair_color_option_picker)
	await _set_color_button_connections(CharacterFactory.hair_colors, eyebrow_color_option_picker)
	await _set_color_button_connections(CharacterFactory.hair_colors, mustache_color_option_picker)
	await _set_color_button_connections(CharacterFactory.hair_colors, beard_color_option_picker)
	await _set_color_button_connections(CharacterFactory.lip_colors, lip_color_option_picker)
	await _set_color_button_connections(CharacterFactory.eyeshadow_colors, eyeshadow_color_option_picker)
	await _set_color_button_connections(CharacterFactory.eyeliner_colors, eyeliner_color_option_picker)
	await _set_color_button_connections(CharacterFactory.blush_colors, blush_color_option_picker)
	
	await _set_color_button_connections(CharacterFactory.shirt_colors, shirt_color_option_picker)
	await _set_color_button_connections(CharacterFactory.pants_colors, pants_color_option_picker)
	await _set_color_button_connections(CharacterFactory.shirt_colors, sock_color_option_picker)
	await _set_color_button_connections(CharacterFactory.shirt_colors, shoes_color_option_picker)

	# External Icons
	await hair_option_picker.add_empty(hair_icons[hair_icons.size() - 1], _update_character)
	await _set_external_icon_button_connections(hair_icons, CharacterFactory.hair_meshes, hair_option_picker)

	await blush_option_picker.add_empty(empty_icon, _update_character)
	await _set_external_icon_button_connections(blush_icons, CharacterFactory.blush_textures, blush_option_picker)
	await _set_external_icon_button_connections(nose_icons, CharacterFactory.nose_meshes, noses_option_picker)
	await _set_external_icon_button_connections(ear_icons, CharacterFactory.ear_meshes, ears_option_picker)

	# Textures
	await eyeshadow_option_picker.add_empty(empty_icon, _update_character)
	await _set_single_texture_button_connections(CharacterFactory.eyeshadow_textures, eyeshadow_option_picker)
	await eyeliner_option_picker.add_empty(empty_icon, _update_character)
	await _set_single_texture_button_connections(CharacterFactory.eyeliner_textures, eyeliner_option_picker)
	await eyebrow_piercings_option_picker.add_empty(empty_icon, _update_character)
	await _set_single_texture_button_connections(CharacterFactory.eyebrow_piercing_textures, eyebrow_piercings_option_picker)

	await glasses_option_picker.add_empty(empty_icon, _update_character)
	await _set_texture_button_connections(CharacterFactory.glasses_textures, glasses_option_picker, 1)
	await _set_texture_button_connections(CharacterFactory.eye_textures, eyes_option_picker)
	await _set_texture_button_connections(CharacterFactory.mouth_textures, mouths_option_picker, 1)

	await mustaches_option_picker.add_empty(empty_icon, _update_character)
	await _set_texture_button_connections_color_override(CharacterFactory.mustache_textures, mustaches_option_picker, 2)
	await _set_texture_button_connections_color_override(CharacterFactory.eyebrow_textures, eyebrows_option_picker)

	# Build in icons
	await _set_resource_button_connections(CharacterFactory.shirt_datas, shirt_option_picker)
	await _set_resource_button_connections(CharacterFactory.pants_datas, pants_option_picker)
	await _set_resource_button_connections(CharacterFactory.sock_datas, sock_option_picker)
	await _set_resource_button_connections(CharacterFactory.shoes_datas, shoes_option_picker)

	await beards_option_picker.add_empty(empty_icon, _update_character)
	await _set_resource_button_connections(CharacterFactory.beard_textures, beards_option_picker)
	await earrings_option_picker.add_empty(empty_icon, _update_character)
	await _set_resource_button_connections(CharacterFactory.earring_meshes, earrings_option_picker)
	await nose_piercings_option_picker.add_empty(empty_icon, _update_character)
	await _set_resource_button_connections(CharacterFactory.nose_piercing_datas, nose_piercings_option_picker)

	await belt_option_picker.add_empty(empty_icon, _update_character)
	await _set_resource_button_connections(CharacterFactory.belt_datas, belt_option_picker)
	await wrists_option_picker.add_empty(empty_icon, _update_character)
	await _set_resource_button_connections(CharacterFactory.wrists_datas, wrists_option_picker)

	# Offset Buttons
	eye_buttons.set_values(eye_range, _update_character)
	eyebrow_buttons.set_values(eyebrow_range, _update_character)
	mouth_buttons.set_values(mouth_range, _update_character)
	glasses_buttons.set_values(glasses_range, _update_character)
	mustache_buttons.set_values(mustache_range, _update_character)

	_update_character()


func _process(delta: float):
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
	edited_resource.nose_piercing_index = nose_piercings_option_picker.get_current_index()
	edited_resource.eyebrow_piercing_index = eyebrow_piercings_option_picker.get_current_index()
	edited_resource.earring_index = earrings_option_picker.get_current_index()

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

	# Offset Stuff
	edited_resource.eye_values = eye_buttons.get_values()
	edited_resource.eyebrow_values = eyebrow_buttons.get_values()
	edited_resource.mouth_values = mouth_buttons.get_values()
	edited_resource.glasses_values = glasses_buttons.get_values()
	edited_resource.mustache_values = mustache_buttons.get_values()

	CharacterFactory.refresh_character(preview_scene.current_character)


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


func _set_texture_button_connections(collection, picker: CreatorGallery, remove_last_count: int = 0):
	var last: int = collection.get_layers() - 1 - remove_last_count
	var index := 0
	for option: int in collection.get_layers() - 1:
		var texture := ImageTexture.create_from_image(collection.get_layer_data(option))
		picker.add_button(texture, _update_character)

		index += 1
		if index >= last:
			return


func _set_texture_button_connections_color_override(collection, picker: CreatorGallery, remove_last_count: int = 0):
	var last: int = collection.get_layers() - 1 - remove_last_count
	var index: int = 0
	for option: int in collection.get_layers() - 1:
		var image: Image = collection.get_layer_data(option)
		image.adjust_bcs(0, 1, 1)
		picker.add_button(ImageTexture.create_from_image(image), _update_character)

		index += 1
		if index >= last:
			return


func _set_single_texture_button_connections(collection, picker: CreatorGallery):
	for option in collection:
		var image: Image = option.get_layer_data(0)
		image.adjust_bcs(0, 1, 1)
		picker.add_button(ImageTexture.create_from_image(image), _update_character)


func _set_resource_button_connections(collection, picker: CreatorGallery):
	for option in collection:
		picker.add_button(option.icon, _update_character)


func _randomize():
	var rng := RandomNumberGenerator.new()

	# Face stuff
	skin_color_tracker.index = rng.randi_range(0, CharacterFactory.skin_colors.size() - 1)

	eyes_option_picker.set_button_index(rng.randi_range(0, eyes_option_picker.get_option_count()))
	eyebrows_option_picker.set_button_index(rng.randi_range(0, eyebrows_option_picker.get_option_count()))
	mouths_option_picker.set_button_index(rng.randi_range(0, mouths_option_picker.get_option_count()))
	noses_option_picker.set_button_index(rng.randi_range(0, noses_option_picker.get_option_count()))
	ears_option_picker.set_button_index(rng.randi_range(0, ears_option_picker.get_option_count()))
	hair_option_picker.set_button_index(rng.randi_range(0, hair_option_picker.get_option_count()))

	eyeshadow_option_picker.set_button_index(rng.randi_range(0, eyeshadow_option_picker.get_option_count()))
	eyeliner_option_picker.set_button_index(rng.randi_range(0, eyeliner_option_picker.get_option_count()))
	blush_option_picker.set_button_index(rng.randi_range(0, blush_option_picker.get_option_count()))
	glasses_option_picker.set_button_index(rng.randi_range(0, glasses_option_picker.get_option_count()))
	nose_piercings_option_picker.set_button_index(rng.randi_range(0, nose_piercings_option_picker.get_option_count()))
	eyebrow_piercings_option_picker.set_button_index(rng.randi_range(0, eyebrow_piercings_option_picker.get_option_count()))
	earrings_option_picker.set_button_index(rng.randi_range(0, earrings_option_picker.get_option_count()))

	mustaches_option_picker.set_button_index(rng.randi_range(0, mustaches_option_picker.get_option_count()))
	beards_option_picker.set_button_index(rng.randi_range(0, beards_option_picker.get_option_count()))

	eyebrow_color_option_picker.set_button_index(rng.randi_range(0, eyebrow_color_option_picker.get_option_count()))
	hair_color_option_picker.set_button_index(rng.randi_range(0, hair_color_option_picker.get_option_count()))
	hair_color_option_picker.set_button_index(rng.randi_range(0, hair_color_option_picker.get_option_count()))
	mustache_color_option_picker.set_button_index(rng.randi_range(0, mustache_color_option_picker.get_option_count()))
	beard_color_option_picker.set_button_index(rng.randi_range(0, beard_color_option_picker.get_option_count()))

	lip_color_option_picker.set_button_index(rng.randi_range(0, lip_color_option_picker.get_option_count()))
	eyeshadow_color_option_picker.set_button_index(rng.randi_range(0, eyeshadow_color_option_picker.get_option_count()))
	eyeliner_color_option_picker.set_button_index(rng.randi_range(0, eyeliner_color_option_picker.get_option_count()))
	blush_color_option_picker.set_button_index(rng.randi_range(0, blush_color_option_picker.get_option_count()))

	# Body Stuff
	shirt_option_picker.set_button_index(rng.randi_range(0, shirt_option_picker.get_option_count()))
	pants_option_picker.set_button_index(rng.randi_range(0, pants_option_picker.get_option_count()))
	sock_option_picker.set_button_index(rng.randi_range(0, sock_option_picker.get_option_count()))
	shoes_option_picker.set_button_index(rng.randi_range(0, shoes_option_picker.get_option_count()))
	belt_option_picker.set_button_index(rng.randi_range(0, belt_option_picker.get_option_count()))
	wrists_option_picker.set_button_index(rng.randi_range(0, wrists_option_picker.get_option_count()))

	shirt_color_option_picker.set_button_index(rng.randi_range(0, shirt_color_option_picker.get_option_count()))
	pants_color_option_picker.set_button_index(rng.randi_range(0, pants_color_option_picker.get_option_count()))
	sock_color_option_picker.set_button_index(rng.randi_range(0, sock_color_option_picker.get_option_count()))
	shoes_color_option_picker.set_button_index(rng.randi_range(0, shoes_color_option_picker.get_option_count()))

	# eye_buttons.vertical_current = rng.randf_range(eye_buttons.vertical_range.x, eye_buttons.vertical_range.y)
	# eye_buttons.horizontal_current = rng.randf_range(eye_buttons.horizontal_range.x, eye_buttons.horizontal_range.y)
	# eye_buttons.rotation_current = rng.randf_range(eye_buttons.rotation_range.x, eye_buttons.rotation_range.y)
	# eye_buttons.scale_current = rng.randf_range(eye_buttons.scale_range.x, eye_buttons.scale_range.y)

	# eyebrow_buttons.vertical_current = rng.randf_range(eyebrow_buttons.vertical_range.x, eyebrow_buttons.vertical_range.y)
	# eyebrow_buttons.horizontal_current = rng.randf_range(eyebrow_buttons.horizontal_range.x, eyebrow_buttons.horizontal_range.y)
	# eyebrow_buttons.rotation_current = rng.randf_range(eyebrow_buttons.rotation_range.x, eyebrow_buttons.rotation_range.y)
	# eyebrow_buttons.scale_current = rng.randf_range(eyebrow_buttons.scale_range.x, eyebrow_buttons.scale_range.y)

	# mouth_buttons.vertical_current = rng.randf_range(mouth_buttons.vertical_range.x, mouth_buttons.vertical_range.y)
	# mouth_buttons.scale_current = rng.randf_range(mouth_buttons.scale_range.x, mouth_buttons.scale_range.y)

	# mustache_buttons.vertical_current = rng.randf_range(mustache_buttons.vertical_range.x, mustache_buttons.vertical_range.y)
	# mustache_buttons.scale_current = rng.randf_range(mustache_buttons.scale_range.x, mustache_buttons.scale_range.y)

	# glasses_buttons.vertical_current = rng.randf_range(glasses_buttons.vertical_range.x, glasses_buttons.vertical_range.y)

	_update_character()


func _reset():
	skin_color_tracker.index = 0

	eyes_option_picker.set_button_index(0)
	eyebrows_option_picker.set_button_index(0)
	mouths_option_picker.set_button_index(0)
	noses_option_picker.set_button_index(0)
	ears_option_picker.set_button_index(0)

	hair_option_picker.set_button_index(-1)
	eyeshadow_option_picker.set_button_index(-1)
	eyeliner_option_picker.set_button_index(-1)
	blush_option_picker.set_button_index(-1)
	glasses_option_picker.set_button_index(-1)
	nose_piercings_option_picker.set_button_index(-1)
	eyebrow_piercings_option_picker.set_button_index(-1)
	earrings_option_picker.set_button_index(-1)

	mustaches_option_picker.set_button_index(-1)
	beards_option_picker.set_button_index(-1)

	eyebrow_color_option_picker.set_button_index(0)
	hair_color_option_picker.set_button_index(0)
	hair_color_option_picker.set_button_index(0)
	mustache_color_option_picker.set_button_index(0)
	beard_color_option_picker.set_button_index(0)

	lip_color_option_picker.set_button_index(0)
	eyeshadow_color_option_picker.set_button_index(0)
	eyeliner_color_option_picker.set_button_index(0)
	blush_color_option_picker.set_button_index(0)

	# Body Stuff
	shirt_option_picker.set_button_index(0)
	pants_option_picker.set_button_index(0)
	sock_option_picker.set_button_index(0)
	shoes_option_picker.set_button_index(0)
	belt_option_picker.set_button_index(-1)
	wrists_option_picker.set_button_index(-1)

	shirt_color_option_picker.set_button_index(0)
	pants_color_option_picker.set_button_index(0)
	sock_color_option_picker.set_button_index(0)
	shoes_color_option_picker.set_button_index(0)

	eye_buttons.vertical_current = 0
	eye_buttons.horizontal_current = 0
	eye_buttons.rotation_current = 0
	eye_buttons.scale_current = 1

	eyebrow_buttons.vertical_current = 0
	eyebrow_buttons.horizontal_current = 0
	eyebrow_buttons.rotation_current = 0
	eyebrow_buttons.scale_current = 1

	mouth_buttons.vertical_current = 0
	mouth_buttons.scale_current = 1

	mustache_buttons.vertical_current = 0
	mustache_buttons.scale_current = 1

	glasses_buttons.vertical_current = 0

	_update_character()


func _finish():
	edited_resource.icon = await preview_scene.create_icon(edited_resource)
	scene_loader.load_scenes(next_scenes)
