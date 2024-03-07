@tool
class_name NPCDock
extends Control


@export var npc_customizer: NPCCustomizer


func get_preview_callback() -> Callable:
	return Callable(npc_customizer._set_preview)


func set_preview_update_callback(_callback: Callable):
	npc_customizer.update_preview_callback = _callback


func set_pickers(preview_scene):
	npc_customizer.set_pickers(preview_scene)


func set_rotation_slider(value):
	npc_customizer.rotation_slider.value_changed.connect(value)


func set_zoom_slider(value):
	npc_customizer.zoom_slider.value_changed.connect(value)
