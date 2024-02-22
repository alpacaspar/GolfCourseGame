extends Resource


@export var min_speed: int
@export var max_speed: int
@export var vertical_amount: float
@export var speed_threshold: float

@export var club_visuals: PackedScene


func _init(_min_speed := 0, _max_speed := 50, _vertical_amount := .5, _speed_threshold := 0, _club_visuals = null):
	min_speed = _min_speed
	max_speed = _max_speed
	vertical_amount = _vertical_amount
	speed_threshold = _speed_threshold
	club_visuals = _club_visuals
