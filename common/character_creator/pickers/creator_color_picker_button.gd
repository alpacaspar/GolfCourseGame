class_name CreatorColorPickerOption
extends Control


@export var button: Button
@export var texture: TextureRect


func _process(_delta):
    custom_minimum_size = Vector2(size.y, 0)
