class_name Role
extends Resource


@export var display_name: String = "New Role"

@export_group("Actions")
@export var primary_action := PackedScene.new()
## The primary animation to play when the role performs the primary action.
@export var primary_animation := &""
## The primary equipment to attach to the unit when the role performs the primary action.
@export var primary_equipment := PackedScene.new()
