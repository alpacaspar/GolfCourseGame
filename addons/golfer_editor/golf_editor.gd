@tool
extends EditorPlugin


var dock: Node


func _enter_tree():
	# Initialization of the plugin goes here.
	dock = preload("res://addons/golfer_editor/ui/golfer_dock.tscn").instantiate()

	add_control_to_dock(DOCK_SLOT_RIGHT_UL, dock)


func _exit_tree():
	# Clean-up of the plugin goes here.
	remove_control_from_docks(dock)
	dock.free()
