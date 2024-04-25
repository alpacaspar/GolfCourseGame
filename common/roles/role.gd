class_name Role
extends Resource


@export var display_name: String
@export var desired_distance := 2.0
@export var target_type: TargetType = TargetType.OPPONENT
@export var unit_scene: PackedScene = PackedScene.new()
## The primary animation to play when the role performs the primary action.
@export var primary_animation: StringName
## The primary equipment to attach to the unit when the role performs the primary action.
@export var primary_equipment: PackedScene = PackedScene.new()


func _init(name: String = "", distance_desired: float = 2.0):
    display_name = name
    desired_distance = distance_desired


enum TargetType {
    TEAMMATE,
    OPPONENT
}
