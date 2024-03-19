@tool
class_name SequenceNode
extends GraphNode


@export var option_scene: PackedScene
@export var add_option_button: Button

var options := []


func on_ready():
	add_option_button.pressed.connect(_add_option)


func on_process(delta):
	set_slot_enabled_right(0, get_child_count() < 6)
	reset_size()


func _add_option():
	var text_option = option_scene.instantiate() as DialogOption

	add_child(text_option)
	move_child(add_option_button, get_child_count())
	text_option.setup(Callable(_remove_option), _drag_option)
	options.append(text_option)

	set_slot_enabled_right(get_child_count() - 2, true)


func _remove_option(option):
	options.erase(option)
	option.queue_free()
	
	set_slot_enabled_right(get_child_count() - 2, false)


func _drag_option():
	pass
