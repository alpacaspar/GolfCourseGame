class_name GolferResource
extends NPCResource


@export var level: int
@export var golf_class: String


func _init(_golf_class := "", _level := 0, _npc_resource: NPCResource = null):
    super(_npc_resource.name,
        _npc_resource.eye_index,
        _npc_resource.nose_index,
        _npc_resource.mouth_index,
        _npc_resource.hair_index,
        _npc_resource.accessory_index,
        _npc_resource.chin_value)

    golf_class = _golf_class
    level = _level
