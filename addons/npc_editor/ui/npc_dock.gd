@tool
class_name NPCDock
extends Control


@export var npc_customizer: NPCCustomizer


func _get_preview_callback() -> Callable:
	return Callable(npc_customizer._set_preview)


func _set_preview_update_callback(_callback: Callable):
	npc_customizer.update_preview_callback = _callback


func _set_rotation_slider(value):
	npc_customizer.rotation_slider.value_changed.connect(value)


func _set_zoom_slider(value):
	npc_customizer.zoom_slider.value_changed.connect(value)


func _cleanup():
	npc_customizer._cleanup()
	