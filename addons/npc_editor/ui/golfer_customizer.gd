@tool
class_name GolferCustomizer
extends Panel


@export var golfer_resource: ResourceLoadingHandler

@export var generate_golfer_button: Button
@export var golfer_name_field: LineEdit
@export var level_field: SpinBox
@export var class_dropdown: OptionButton

@export var power_label: Label
@export var stamina_label: Label


func _ready():
	golfer_resource._set_value()


func _process(delta):
	pass
