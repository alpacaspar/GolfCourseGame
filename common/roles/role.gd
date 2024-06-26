class_name Role
extends Resource


@export var display_name := "New Role"

@export_group("Stats")
@export var base_stamina := 100
@export var base_power := 10

@export_group("Behaviour")
@export var move_speed := 3.0
@export var max_search_range := 300.0

@export_range(0, 1) var block_chance := 0.5
@export var attack_detection_range := 3.0
@export var block_move_speed := 2.0

@export var attack_range := 3.0
@export var attack_speed := 3.0

@export_range(0, 1) var ball_use_probability := 0.2
@export_range(0, 360) var max_drive_range := 10.0
@export_range(0, 360) var max_drive_angle := 20.0

@export var max_ball_search_range := 10.0
@export var max_unit_search_range := 10.0

@export_group("Actions")
## The primary equipment to attach to the unit when the role performs the primary action.
@export var primary_equipment := PackedScene.new()

@export_group("UI")
@export var descriptive_letter: String = ""


func get_behaviour_settings() -> Dictionary:
	return {
		"move_speed": move_speed,
		"max_search_range": max_search_range,
		"block_chance": block_chance,
		"block_move_speed": block_move_speed,
		"attack_range": attack_range,
		"attack_speed": attack_speed,
		"attack_detection_range": attack_detection_range,
		"ball_use_probability": ball_use_probability,
		"max_drive_range": max_drive_range,
		"max_drive_angle": max_drive_angle,
		"max_ball_search_range": max_ball_search_range,
		"max_unit_search_range": max_unit_search_range,
	}
