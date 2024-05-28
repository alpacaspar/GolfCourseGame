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
@export var shirt_index: int
@export var pants_index: int

@export var hair_color_index: int
@export var skin_color_index: int
@export var shirt_color_index: int
@export var pants_color_index: int

@export var eye_offset: float
@export var eyebrow_offset: float
@export var mouth_offset: float
@export var mouth_size: float

@export var icon: Texture2D


func _init(_name := "", 
    _eye_index := 0, _eyebrow_index := 0, _nose_index := 0, _ear_index := 0, _mouth_index := 0, _hair_index := 0, _accessory_index := 0, _shirt_index := 0, _pants_index := 0,
    _hair_color_index := 0, _skin_color_index := 0, _shirt_color_index := 0, _pants_color_index := 0,
    _eye_offset := 0, _eyebrow_offset := 0, _mouth_offset := 0, _mouth_size:= 0, _icon: Texture2D = null):
    name = _name
    
    eye_index = _eye_index
    eyebrow_index = _eyebrow_index
    nose_index = _nose_index
    ear_index = _ear_index
    mouth_index = _mouth_index
    hair_index = _hair_index
    accessory_index = _accessory_index
    shirt_index = _shirt_index
    pants_index = _pants_index

    hair_color_index = _hair_color_index
    skin_color_index = _skin_color_index
    shirt_color_index = _shirt_color_index
    pants_color_index = _pants_color_index

    eye_offset = _eye_offset
    eyebrow_offset = _eyebrow_offset
    mouth_offset = _mouth_offset
    mouth_size = _mouth_size
    icon = _icon


func overwrite(resource: NPCResource):
    name = resource.name

    eye_index = resource.eye_index
    eyebrow_index = resource.eyebrow_index
    nose_index = resource.nose_index
    ear_index = resource.ear_index
    mouth_index = resource.mouth_index
    hair_index = resource.hair_index
    accessory_index = resource.accessory_index
    shirt_index = resource.shirt_index
    pants_index = resource.pants_index

    hair_color_index = resource.hair_color_index
    skin_color_index = resource.skin_color_index
    shirt_color_index = resource.shirt_color_index
    pants_color_index = resource.pants_color_index

    eye_offset = resource.eye_offset
    eyebrow_offset = resource.eyebrow_offset
    mouth_offset = resource.mouth_offset
    mouth_size = resource.mouth_size
    icon = resource.icon
