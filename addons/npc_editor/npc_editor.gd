@tool
extends EditorPlugin


var dock: Node
var preview_scene: Node


func _enter_tree():
	# Initialization of the plugin goes here.
	dock = preload("res://addons/npc_editor/ui/npc_dock.tscn").instantiate()
	preview_scene = preload("res://addons/npc_editor/preview_scene.tscn").instantiate()
	add_child(preview_scene)

	dock.make_ready()
	preview_scene.make_ready()

	preview_scene.callback = Callable(dock._set_preview)
	dock.update_preview_callback = Callable(preview_scene._edit_character)
	
	dock.set_rotation_slider(preview_scene._set_rotation)
	dock.set_zoom_slider(preview_scene._set_zoom)
	dock.set_pickers(preview_scene)
	
	add_control_to_dock(DOCK_SLOT_RIGHT_UL, dock)


func _process(delta):
	dock.on_process(delta)
	preview_scene.on_process(delta)


func _exit_tree():
	# Remove the dock.
	remove_control_from_docks(dock)
	
	dock.free()
	preview_scene.free()
