class_name UnitIcon
extends Node


@export var icon: TextureRect

@export var class_letter: Label
@export var level_text: Label

@export var button: Button

var current_golfer: GolferResource = null
var callback: Callable

var can_click := true


func _ready():
	button.gui_input.connect(_on_button_gui_input)


func set_values(resource: GolferResource):
	current_golfer = resource
	
	level_text.text = str(resource.level)
	class_letter.text = resource.role.descriptive_letter
	icon.texture = resource.npc_resource.icon


func set_empty():
	level_text.text = "X"
	class_letter.text = ""
	
	icon.texture = null
	current_golfer = null


func _on_button_gui_input(event):
	if !can_click:
		return

	if event is InputEventMouseButton and event.pressed:
		callback.call(self, event)
