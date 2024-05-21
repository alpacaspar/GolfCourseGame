class_name TeamResource
extends Resource


@export var leader: RivalResource
@export var units: Array[GolferResource] = []


func get_composition() -> Array:
    return units + [leader]


func size() -> int:
    return units.size() + 1
