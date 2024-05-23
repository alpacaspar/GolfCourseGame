class_name Role
extends Resource


@export var display_name := "New Role"
@export_group("Stats")
@export var base_stamina := 100
@export var base_power := 10

@export_group("Actions")
@export var primary_action := PackedScene.new()
@export var animation_blend_tree := AnimationNodeBlendTree.new()
## The primary equipment to attach to the unit when the role performs the primary action.
@export var primary_equipment := PackedScene.new()

@export_group("UI")
@export var descriptive_letter: String


func _init(name: String = "", distance_desired: float = 2.0):
	display_name = name
	desired_distance = distance_desired


enum TargetType {
	TEAMMATE,
	OPPONENT
}
