class_name Role
extends Resource


@export var display_name: String = "New Role"
@export var combat_distance := 5.0
@export var action_range := 1.0

@export_group("Actions")
@export var primary_action := PackedScene.new()
## The primary animation to play when the role performs the primary action.
@export var primary_animation: StringName
## The primary equipment to attach to the unit when the role performs the primary action.
@export var primary_equipment := PackedScene.new()
