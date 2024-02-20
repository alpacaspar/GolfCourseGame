extends Node


var active_provider: InputProvider:
	set = set_active_provider


func _input(event: InputEvent):
	if active_provider:
		active_provider._on_input(event)


func _process(_delta: float):
	if active_provider:
		active_provider._on_process()


func set_active_provider(new_provider: InputProvider):
	active_provider._on_exit()
	active_provider = new_provider
	active_provider._on_enter()
