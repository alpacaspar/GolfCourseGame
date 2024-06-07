class_name CreatorColorPicker
extends Control


@export var tracker: IndexTracker

@export var color_button_prefab: PackedScene
@export var button_holder: Control

var button_group: ButtonGroup
var last_index: int


func _ready():
	button_group = ButtonGroup.new()


func _process(_delta):	
	if tracker == null:
		return
	
	if tracker.index != last_index:
		last_index = tracker.index
		set_button_index(last_index)


func add_button(color: Color, button_callback):
	var button = color_button_prefab.instantiate() as CreatorColorPickerOption
	button_holder.add_child(button)

	if tracker != null:
		button.button.pressed.connect(_update_tracker)
	button.button.pressed.connect(button_callback)

	button.button.button_group = button_group
	
	var image = load("res://addons/npc_editor/ui/solid_white.png").duplicate()
	image.fill(color)
	button.texture.texture = ImageTexture.create_from_image(image)


func get_current_index() -> int:
	for button in button_group.get_buttons():
		if button.button_pressed:
			return button_group.get_buttons().find(button)
	
	return 0


func set_button_index(index: int):
	for button in button_group.get_buttons():
		button.button_pressed = button_group.get_buttons().find(button) == index


func _update_tracker():
	tracker.index = get_current_index()


func get_option_count() -> int:
	return button_group.get_buttons().size() - 1
