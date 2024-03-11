@tool
extends Control


var active: bool = false

@export var sequence_resource: SequenceResourceLoader
@export var extended_visuals: Control

@export var sequencer_functionality: SequencerFunctionality

var size_threshhold = 300.0


func _ready():
	sequence_resource.set_value()
	active = true


func _process(delta):
	if not Engine.is_editor_hint():
		return

	if not active:
		return

	if size.y > size_threshhold:
		extended_visuals.visible = true
	else:
		extended_visuals.visible = false


func cleanup():
	sequencer_functionality.cleanup()
	active = false
