@tool
class_name SequencerFunctionality
extends Control


var active: bool = false

@export var camera_window: Control
@export var dialog_window: Control
@export var event_window: Control

@export var timeline_slider: Slider
@export var timeline_line: Control

var slider_value: float


func _ready():
	active = true

	await get_tree().create_timer(.1).timeout

	timeline_slider.min_value = 0
	timeline_slider.step = timeline_slider.size.x / 60
	timeline_slider.max_value = timeline_slider.size.x


func _process(delta):
	if not Engine.is_editor_hint():
		return

	if not active:
		return

	timeline_line.position.x = (timeline_slider.value * .99) + 104
	slider_value = timeline_slider.value / timeline_slider.max_value


func cleanup():
	active = false
