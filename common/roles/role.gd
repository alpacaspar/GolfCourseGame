class_name Role
extends Resource


@export var display_name := "New Role"

@export_group("Actions")
@export var primary_action := PackedScene.new()
@export var animation_blend_tree := AnimationNodeBlendTree.new()
## The primary equipment to attach to the unit when the role performs the primary action.
@export var primary_equipment := PackedScene.new()
