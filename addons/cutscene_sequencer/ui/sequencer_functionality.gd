@tool
class_name SequencerFunctionality
extends Control


@export var camera_window: Control
@export var dialog_window: Control
@export var event_window: Control

@export var timeline_slider: Slider
@export var timeline_line: Control

@export var camera_timeline: TimelineFunctionality
@export var dialogue_timeline: TimelineFunctionality
@export var event_timeline: TimelineFunctionality

var slider_value: float


func on_ready():
	await get_tree().create_timer(.1).timeout

	camera_timeline.on_ready()
	dialogue_timeline.on_ready()
	event_timeline.on_ready()

	timeline_slider.min_value = 0
	timeline_slider.step = timeline_slider.size.x / 60
	timeline_slider.max_value = timeline_slider.size.x


func on_process(delta):
	_check_size_changed()
	
	camera_timeline.on_process(delta)
	dialogue_timeline.on_process(delta)
	event_timeline.on_process(delta)

	timeline_line.position.x = (timeline_slider.value * .99) + 104
	slider_value = timeline_slider.value / timeline_slider.max_value


@onready var last_size: Vector2 = size
func _check_size_changed():
	if size != last_size:
		timeline_slider.min_value = 0
		timeline_slider.step = timeline_slider.size.x / 60
		timeline_slider.max_value = timeline_slider.size.x
		last_size = size
