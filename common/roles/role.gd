class_name Role
extends Resource


@export var display_name := "New Role"

@export_group("Stats")
@export var base_stamina := 100
@export var base_power := 10

@export_group("Behaviour")
@export var move_speed := 3.0
@export var block_move_speed := 2.0
@export var attack_range := 3.0
@export var attack_speed := 3.0

@export var max_drive_range := 10.0
@export var max_drive_angle := 20.0

@export var max_ball_search_range := 10.0
@export var max_unit_search_range := 10.0

@export_group("Actions")
## The primary equipment to attach to the unit when the role performs the primary action.
@export var primary_equipment := PackedScene.new()

@export_group("UI")
@export var descriptive_letter: String = ""
