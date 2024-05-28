extends Control


@export var name_label: Label

@export var stamina_label: Label
@export var power_label: Label
@export var experience_label: Label
@export var level_label: Label
@export var bond_label: Label

@export var role_label: Label


func set_values(golfer: GolferResource):
	name_label.text = golfer.npc_resource.name
	role_label.text = golfer.role.display_name

	stamina_label.text = str(golfer.stamina)
	power_label.text = str(golfer.power)
	experience_label.text = str(golfer.experience)
	level_label.text = str(golfer.level)
	bond_label.text = str(golfer.bond)

	visible = true


func hide_ui():
	visible = false
