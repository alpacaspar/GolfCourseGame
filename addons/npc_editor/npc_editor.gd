@tool
extends EditorPlugin


var dock
var preview_scene


func _enter_tree():
	# Initialization of the plugin goes here.
	dock = preload("res://addons/npc_editor/ui/npc_dock.tscn").instantiate()
	preview_scene = preload("res://addons/npc_editor/preview_scene.tscn").instantiate()
	add_child(preview_scene)

	preview_scene.make_ready(dock.get_preview_callback())
	dock.set_preview_update_callback(Callable(preview_scene._edit_character))
	dock.set_rotation_slider(preview_scene._set_rotation)
	dock.set_zoom_slider(preview_scene._set_zoom)
	dock.set_pickers(preview_scene)
	
	add_control_to_dock(DOCK_SLOT_RIGHT_UL, dock)


func _exit_tree():
	# Remove the dock.
	remove_control_from_docks(dock)
	
	preview_scene._cleanup()

	# Erase the control from the memory.
	dock.free()
	preview_scene.free()
