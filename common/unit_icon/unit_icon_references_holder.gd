extends Node


@export var icon: TextureRect

@export var name_text: RichTextLabel

@export var power_text: RichTextLabel
@export var stamina_text: RichTextLabel
@export var somethignWElsw: RichTextLabel


func set_values(npc_resource: NPCResource):
	name_text.text = npc_resource.name

