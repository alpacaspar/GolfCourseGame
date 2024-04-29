class_name NPCResource
extends Resource


@export var name: String

@export var eye_index: int
@export var eyebrow_index: int
@export var nose_index: int
@export var ear_index: int
@export var mouth_index: int
@export var hair_index: int
@export var accessory_index: int

@export var hair_color: Color
@export var skin_color: Color
@export var shirt_color: Color
@export var pants_color: Color

@export var eye_offset: float
@export var eyebrow_offset: float
@export var mouth_offset: float
@export var mouth_size: float


func _init(_name := "", 
    _eye_index := 0, _eyebrow_index := 0, _nose_index := 0, _ear_index := 0, _mouth_index := 0, _hair_index := 0, _accessory_index := 0, 
    _hair_color := Color.WHITE, _skin_color := Color.WHITE, _shirt_color := Color.WHITE, _pants_color := Color.WHITE,
    _eye_offset := 0, _eyebrow_offset := 0, _mouth_offset := 0, _mouth_size:= 0):
    name = _name
    
    eye_index = _eye_index
    eyebrow_index = _eyebrow_index
    nose_index = _nose_index
    ear_index = _ear_index
    mouth_index = _mouth_index
    hair_index = _hair_index
    accessory_index = _accessory_index

    hair_color = _hair_color
    skin_color = _skin_color
    shirt_color = _shirt_color
    pants_color = _pants_color

    eye_offset = _eye_offset
    eyebrow_offset = _eyebrow_offset
    mouth_offset = _mouth_offset
    mouth_size = _mouth_size
