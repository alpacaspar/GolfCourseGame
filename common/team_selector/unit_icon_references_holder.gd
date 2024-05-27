class_name UnitIcon
extends Node


@export var icon: TextureRect

@export var class_letter: Label
@export var level_text: Label

@export var button: Button

var current_golfer: GolferResource = null
var callback: Callable


func _ready():
	button.pressed.connect(_on_clicked)


func set_values(resource: GolferResource):
	current_golfer = resource
	
	level_text.text = str(resource.level)
	class_letter.text = resource.role.descriptive_letter


func set_empty():
	level_text.text = "X"
	class_letter.text = ""
	
	icon.texture = null
	current_golfer = null


func _on_clicked():
	callback.call(self)
