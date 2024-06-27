extends Node


var active_provider: InputProvider

var is_provider_active: bool:
	get:
		return is_instance_valid(active_provider)


func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS


func _input(event: InputEvent):
	if is_instance_valid(active_provider):
		active_provider._on_input(event)

	if Input.is_action_just_released("ui_cancel"):
		toggle_mouse_lock(Input.mouse_mode == Input.MOUSE_MODE_VISIBLE)


func _process(_delta: float):
	if is_instance_valid(active_provider):
		active_provider._on_process()


func toggle_mouse_lock(value: bool):
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED if value else Input.MOUSE_MODE_VISIBLE)


## Change the active input provider.
## Can be set to `null` to disable input.
func set_active_provider(new_provider: InputProvider):
	if is_instance_valid(active_provider):
		active_provider._on_exit()

	active_provider = new_provider

	if is_instance_valid(active_provider):
		active_provider._on_enter()
