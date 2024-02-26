@tool
extends EditorPlugin


var dock


func _enter_tree():
	# Initialization of the plugin goes here.
	dock = preload("res://addons/npc_editor/ui/npc_dock.tscn").instantiate()
	add_control_to_dock(DOCK_SLOT_RIGHT_UL, dock)


func _exit_tree():
	# Clean-up of the plugin goes here.
	# Remove the dock.
	remove_control_from_docks(dock)
	# Erase the control from the memory.
	dock.free()
