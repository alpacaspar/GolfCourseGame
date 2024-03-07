@tool
class_name NPCCustomizerPicker
extends Control


@export var button_group: ButtonGroup
@export var npc_customizer_button_prefab: PackedScene

@export var label: Label
@export var button_holder: Control


func _ready():
	label.text = button_group.resource_name


func add_button(texture: Texture, button_callback):
	var button = npc_customizer_button_prefab.instantiate() as NPCCustomizerOption
	button_holder.add_child(button)
	button.button.pressed.connect(button_callback)
	button.button.button_group = button_group
	button.texture.texture = texture


func get_current_index() -> int:
	for button in button_group.get_buttons():
		if button.button_pressed:
			return button_group.get_buttons().find(button)
	
	return 0


func set_button_index(index: int):
	for button in button_group.get_buttons():
		button.button_pressed = button_group.get_buttons().find(button) == index
