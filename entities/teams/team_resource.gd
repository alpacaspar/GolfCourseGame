class_name TeamResource
extends Resource


@export var leader: RivalResource
@export var units: Array[GolferResource] = []


func size() -> int:
  return units.size() + 1