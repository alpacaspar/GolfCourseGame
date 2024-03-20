class_name Role
extends Resource


@export var display_name: String
@export var desired_distance := 2.0
@export var target_type: TargetType = TargetType.OPPONENT


func _init(name: String = "", distance_desired: float = 2.0):
	display_name = name
	desired_distance = distance_desired


enum TargetType {
	TEAMMATE,
	OPPONENT
}
