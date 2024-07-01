@tool
class_name CreatorGallery
extends Control


@export var npc_customizer_button_prefab: PackedScene
@export var button_holder: Control

@export var show_slider: bool
@export var slider: ScrollBar
@export var scroll_container: ScrollContainer

@export var slider_grab_sound: String
@export var slider_ungrab_sounds: String

var includes_empty := false
var button_group: ButtonGroup


func _ready():
	button_group = ButtonGroup.new()

	if slider != null:
		if !show_slider:
			slider.visible = false
			get_child(1).get_child(2).visible = false
		
		# slider.drag_started.connect(play_slider_grab_sound)
		# slider.drag_ended.connect(play_slider_ungrab_sound)
		slider.value_changed.connect(_scroll)


var last_val = 0
func _process(_delta):
	if scroll_container == null:
		return
	
	if last_val != scroll_container.scroll_vertical:
		_scroll(scroll_container.scroll_vertical)

	slider.max_value = button_holder.size.y - scroll_container.size.y
	slider.page = slider.max_value / 5
	last_val = scroll_container.scroll_vertical


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


func _scroll(value := 0):
	scroll_container.scroll_vertical = value
	slider.value = value


func play_slider_grab_sound(): Wwise.post_event(slider_grab_sound, self)
func play_slider_ungrab_sound(_value): Wwise.post_event(slider_ungrab_sounds, self)
