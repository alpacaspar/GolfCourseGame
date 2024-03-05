@tool
extends VBoxContainer


@export var option_scene: PackedScene
@export var option_holder: Control

@export var add_option_button: Button

var options_list: Array[DialogOption]


func _ready():
	add_option_button.pressed.connect(_add_option)
	print(1)


func _process(delta):
	#prints(options_list.size())
	pass


func _add_option():
	var option = option_scene.instantiate() as DialogOption
	option_holder.add_child(option)
	option.setup(Callable(_remove_option), _drag_option)
	options_list.append(option)


func _remove_option(option):
	options_list.erase(option)
	option.queue_free()


func _drag_option():
	pass
