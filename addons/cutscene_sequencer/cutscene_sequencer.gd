@tool
extends EditorPlugin
### Cutscene Sequencer Tool Base Script
### Works with:
	# sequencer_tool_ui
	# sequencer_functionality
	# sequence_node_editing_functionality
	# sequencer_node

	# timeline_functionality
	# timeline_block


var dock


func _enter_tree():
	dock = load("res://addons/cutscene_sequencer/ui/sequencer_tool_ui.tscn").instantiate()
	add_control_to_bottom_panel(dock, "Cutscene Sequencer")

	make_bottom_panel_item_visible(dock)

	dock.on_ready()


func _exit_tree():
	remove_control_from_bottom_panel(dock)
	

func _process(delta):
	dock.on_process(delta)
