extends Control


@export var control_screen: Screen


func _enter_tree():
	control_screen.screen_node = self
