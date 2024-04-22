extends Node3D


var equipment: Node3D:
    get:
        return null if get_child_count() == 0 else get_child(0)


func start_event():
    if equipment:
        equipment.start_event()


func end_event():
    if equipment:
        equipment.end_event()
