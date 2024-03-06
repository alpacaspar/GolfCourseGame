@tool
class_name NPCCustomizer
extends Panel


var active: bool = false

@export var npc_resource: ResourceLoadingHandler

@export var name_field: LineEdit
@export var chin_slider: Slider
@export var preview: TextureRect
@export var error_display: Label
@export var error_icon: TextureRect

@export var eyes_button_group: ButtonGroup
@export var noses_button_group: ButtonGroup
@export var ears_button_group: ButtonGroup
@export var mouths_button_group: ButtonGroup
@export var hair_button_group: ButtonGroup
@export var accessories_button_group: ButtonGroup

@export var zoom_slider: Slider
@export var rotation_slider: Slider
@export var rotation_box: SpinBox

@export var load_button: Button
@export var save_button: Button
@export var save_as_button: Button

var update_preview_callback: Callable

var edited_resource: NPCResource
var current_path: String

var has_error: bool = false


func _ready():
	npc_resource.set_value()

	chin_slider.value_changed.connect(_update_character)
	_set_button_connections(eyes_button_group)
	_set_button_connections(noses_button_group)
	_set_button_connections(ears_button_group)
	_set_button_connections(mouths_button_group)
	_set_button_connections(hair_button_group)
	_set_button_connections(accessories_button_group)

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
	
	edited_resource.eye_index = _get_current_index(eyes_button_group)
	edited_resource.nose_index = _get_current_index(noses_button_group)
	edited_resource.ear_index = _get_current_index(ears_button_group)
	edited_resource.mouth_index = _get_current_index(mouths_button_group)
	edited_resource.hair_index = _get_current_index(hair_button_group)
	edited_resource.accessory_index = _get_current_index(accessories_button_group)

	edited_resource.chin_value = chin_slider.value

	update_preview_callback.call(edited_resource)


func _load():
	var _resource = npc_resource.value

	_set_button_index(eyes_button_group, _resource.eye_index)
	_set_button_index(noses_button_group, _resource.nose_index)
	_set_button_index(ears_button_group, _resource.ear_index)
	_set_button_index(mouths_button_group, _resource.mouth_index)
	_set_button_index(hair_button_group, _resource.hair_index)
	_set_button_index(accessories_button_group, _resource.accessory_index)

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


func _get_current_index(button_group: ButtonGroup) -> int:
	for button in button_group.get_buttons():
		if button.button_pressed:
			return button_group.get_buttons().find(button)
	
	return 0


func _set_button_index(button_group: ButtonGroup, index: int):
	for button in button_group.get_buttons():
		if button_group.get_buttons().find(button) == index:
			button.button_pressed = true
		else:
			button.button_pressed = false


func _set_preview(_texture):
	preview.texture = _texture


func _set_button_connections(button_group: ButtonGroup):
	for button in button_group.get_buttons():
		button.pressed.connect(_update_character)


func _set_rotation_value(_value):
	rotation_slider.value = _value
	rotation_box.value = _value


func _cleanup():
	active = false
