@tool
class_name NPCCustomizer
extends Panel


@export var npc_resource: ResourceLoadingHandler

@export var generate_button: Button
@export var name_field: LineEdit
@export var chin_slider: Slider
@export var preview: TextureRect

@export var eyes_button_group: ButtonGroup
@export var noses_button_group: ButtonGroup
@export var mouths_button_group: ButtonGroup
@export var hair_button_group: ButtonGroup
@export var accessories_button_group: ButtonGroup

@export var rotation_slider: Slider
@export var rotation_box: SpinBox

var update_preview_callback: Callable

var edited_resource: NPCResource


func _ready():
	npc_resource._set_value()

	chin_slider.value_changed.connect(_update_character)
	set_button_connections(eyes_button_group)
	set_button_connections(noses_button_group)
	set_button_connections(mouths_button_group)
	set_button_connections(hair_button_group)
	set_button_connections(accessories_button_group)

	rotation_slider.value_changed.connect(set_rotation_value)
	rotation_box.value_changed.connect(set_rotation_value)

	edited_resource = NPCResource.new()


func _update_character(_value = 0):
	edited_resource.name = name_field.text
	
	edited_resource.eye_index = get_current_index(eyes_button_group)
	edited_resource.nose_index = get_current_index(noses_button_group)
	edited_resource.mouth_index = get_current_index(mouths_button_group)
	edited_resource.hair_index = get_current_index(hair_button_group)
	edited_resource.accessory_index = get_current_index(accessories_button_group)

	edited_resource.chin_value = chin_slider.value

	update_preview_callback.call(edited_resource)


func _set_preview(_texture):
	preview.texture = _texture


func set_button_connections(button_group: ButtonGroup):
	for button in button_group.get_buttons():
		button.pressed.connect(_update_character)


func get_current_index(button_group: ButtonGroup) -> int:
	for button in button_group.get_buttons():
		if button.button_pressed:
			return button_group.get_buttons().find(button)
	
	return 0


func set_rotation_value(_value):
	rotation_slider.value = _value
	rotation_box.value = _value
