class_name Screen
extends Resource


var screen_node: Control


func open():
	screen_node.set_visible(true)


func close():
	screen_node.set_visible(false)
