class_name GolferResource
extends Resource


@export var name := "Joe Schmoe"
@export var level := 1
@export var role := Role.new()

@export var npc_resource: NPCResource

var power: int
var stamina: int
var experience: int


func _init(golfer_name := "", golfer_level := 1, golfer_role: Role = Role.new(), golfer_npc_resource: NPCResource = null):
	name = golfer_name
	level = golfer_level
	role = golfer_role
	npc_resource = golfer_npc_resource

	power = 10
	stamina = 100
