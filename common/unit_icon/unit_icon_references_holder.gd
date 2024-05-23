extends Node


@export var icon: TextureRect

@export var class_letter: Label
@export var level_text: Label


func set_values(resource: GolferResource):
	level_text.text = str(resource.level)
	class_letter.text = resource.role.descripive_letter
