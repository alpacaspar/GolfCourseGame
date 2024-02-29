extends Node


var active_provider: InputProvider

var is_provider_active: bool:
	get:
		return active_provider != null


func _input(event: InputEvent):
	if active_provider:
		active_provider._on_input(event)

	if Input.is_action_just_released("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)	


func _process(_delta: float):
	if active_provider:
		active_provider._on_process()


## Change the active input provider.
## Can be set to `null` to disable input.
func set_active_provider(new_provider: InputProvider):
	if active_provider:
		active_provider._on_exit()
	
	active_provider = new_provider
	
	if active_provider:
		active_provider._on_enter()
