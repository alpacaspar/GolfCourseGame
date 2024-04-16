class_name Team
extends Node


var leader: Unit
var units: Array[Unit]


func size() -> int:
    return units.size() + 1