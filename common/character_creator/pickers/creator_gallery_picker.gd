@tool
class_name CreatorGallery
extends Control


@export var npc_customizer_button_prefab: PackedScene
@export var button_holder: Control

var includes_empty := false
var button_group: ButtonGroup


func _ready():
	button_group = ButtonGroup.new()

	
func add_empty(texture: Texture, button_callback):
	var button := npc_customizer_button_prefab.instantiate() as NPCCustomizerOption
	button_holder.add_child(button)

	button.button.pressed.connect(button_callback)
	button.button.button_group = button_group
	button.texture.texture = texture

	includes_empty = true


func add_button(texture: Texture, button_callback):
	var button := npc_customizer_button_prefab.instantiate() as NPCCustomizerOption
	button_holder.add_child(button)

	button.button.pressed.connect(button_callback)
	button.button.button_group = button_group
	button.texture.texture = texture


func get_current_index() -> int:
	var offset := 1 if includes_empty else 0
	for button: BaseButton in button_group.get_buttons():
		if button.button_pressed:
			return button_group.get_buttons().find(button) - offset
	
	return 0 - offset


func set_button_index(index: int):
	var offset := 1 if includes_empty else 0
	for button: BaseButton in button_group.get_buttons():
		button.button_pressed = button_group.get_buttons().find(button) == index + offset


func get_option_count() -> int:
	return button_group.get_buttons().size() - 1
