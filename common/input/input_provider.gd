class_name InputProvider
extends Node


func _ready():
	if not InputManager.is_provider_active:
		InputManager.set_active_provider(self)


func _on_enter():
	pass


func _on_exit():
	pass


func _on_input(_event: InputEvent):
	pass


func _on_process():
	pass
