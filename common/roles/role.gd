class_name Role
extends Resource


@export var display_name: String
@export var golfer_body_scene: PackedScene


func _init(name: String = "", body_scene: PackedScene = null):
    display_name = name
    golfer_body_scene = body_scene
