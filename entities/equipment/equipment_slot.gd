extends Node3D


var equipment: Node3D:
    get:
        return null if get_child_count() == 0 else get_child(0)


func _on_base_character_animation_event_ended():
    if equipment:
        equipment.end_event()


func _on_base_character_animation_event_started():
    if equipment:
        equipment.start_event()
