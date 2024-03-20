@tool
extends Control


@export var sequence_resource: SequenceResourceLoader
@export var extended_visuals: Control

@export var sequencer_functionality: SequencerFunctionality
@export var node_sequence_functionality: SequenceNodeEditor

@export var context_menu: Control

var size_threshhold = 300.0


func on_ready():
	sequence_resource.set_value()
	sequencer_functionality.on_ready()
	node_sequence_functionality.on_ready()


func on_process(delta):
	if not Engine.is_editor_hint():
		return

	if self == get_tree().edited_scene_root:
		return

	sequencer_functionality.on_process(delta)
	node_sequence_functionality.on_process(delta)

	extended_visuals.visible = size.y > size_threshhold
