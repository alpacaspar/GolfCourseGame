@tool
class_name SequenceNode
extends GraphNode


@export var option_scene: PackedScene
@export var add_option_button: Button

@export var spacer: Control

var options := []
var childamount := 0


func on_ready():
	add_option_button.pressed.connect(_add_option)
	childamount = get_child_count()


func on_process(delta):
	set_slot(1, false, 0, Color.WHITE, get_child_count() - 1 < childamount, 0, Color.GREEN)


func _add_option():
	var text_option = option_scene.instantiate() as DialogOption

	add_child(text_option)
	move_child(add_option_button, get_child_count() - 1)
	move_child(spacer, get_child_count())

	text_option.setup(Callable(_remove_option), _drag_option)
	options.append(text_option)

	set_slot(get_child_count() - 3, false, 0, Color.WHITE, true, 0, Color.GREEN)


func _remove_option(option):
	options.erase(option)
	option.queue_free()
	
	set_slot(get_child_count() - 3, false, 0, Color.WHITE, false, 0, Color.GREEN)


func _drag_option():
	pass
