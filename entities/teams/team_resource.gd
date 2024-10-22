class_name TeamResource
extends Resource


@export var leader: GolferResource
@export var units: Array[GolferResource] = []


func get_composition() -> Array:
    return [leader] + units


func size() -> int:
    return units.size() + 1
