class_name Golfer
extends Resource


@export var name := "Joe Schmoe"
@export var level := 1
@export var role := Role.new()

var power: int
var stamina: int
var experience: int


func _init(golfer_name := "", golfer_level := 1):
	name = golfer_name
	level = golfer_level
	role = Role.new()
	power = 10 * golfer_level
	stamina = 10 * golfer_level
