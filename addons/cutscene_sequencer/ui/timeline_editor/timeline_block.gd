@tool
class_name TimelineBlock
extends Control


@export var left_grabber: Button
@export var right_grabber: Button

@export var dialog_label: Label

var start_value: float
var end_value: float


func on_ready():
	pass


func on_process(delta):
	pass


func set_values(_start_value: float, _end_value: float):
	start_value = _start_value
	end_value = _end_value
