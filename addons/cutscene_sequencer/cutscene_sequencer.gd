@tool
extends EditorPlugin


var dock


func _enter_tree():
	# Initialization of the plugin goes here.
	dock = load("res://addons/cutscene_sequencer/ui/sequencer_tool.tscn").instantiate()
	add_control_to_bottom_panel(dock, "Cutscene Sequencer")

	make_bottom_panel_item_visible(dock)


func _exit_tree():
	dock.cleanup()
	
	remove_control_from_bottom_panel(dock)
	