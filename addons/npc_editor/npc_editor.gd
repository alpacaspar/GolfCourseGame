@tool
extends EditorPlugin


var dock
var previewScene


func _enter_tree():
	# Initialization of the plugin goes here.
	dock = preload("res://addons/npc_editor/ui/npc_dock.tscn").instantiate()
	previewScene = preload("res://addons/npc_editor/preview_scene.tscn").instantiate()
	add_child(previewScene)

	previewScene._make_ready(dock._get_preview_callback())
	dock._set_preview_update_callback(Callable(previewScene._edit_character))
	dock._set_rotation_slider(previewScene._set_rotation)
	dock._set_zoom_slider(previewScene._set_zoom)
	
	add_control_to_dock(DOCK_SLOT_RIGHT_UL, dock)


func _exit_tree():
	# Remove the dock.
	remove_control_from_docks(dock)
	
	previewScene._cleanup()
	dock._cleanup()

	# Erase the control from the memory.
	dock.free()
	previewScene.free()
