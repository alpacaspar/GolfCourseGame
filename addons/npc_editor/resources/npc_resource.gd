class_name NPCResource
extends Resource


@export var name: String

@export var eye_index: int
@export var nose_index: int
@export var ear_index: int
@export var mouth_index: int
@export var hair_index: int
@export var accessory_index: int

@export var chin_value: float


func _init(_name := "", _eye_index := 0, _nose_index := 0, _ear_index := 0, _mouth_index := 0, _hair_index := 0, _accessory_index := 0, _chin_value := 0.0):
    name = _name
    eye_index = _eye_index
    nose_index = _nose_index
    ear_index = _ear_index
    mouth_index = _mouth_index
    hair_index = _hair_index
    accessory_index = _accessory_index
    chin_value = _chin_value
