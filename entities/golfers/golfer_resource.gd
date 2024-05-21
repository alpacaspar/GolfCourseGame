class_name GolferResource
extends Resource


@export var level := 1
@export var role := Role.new()

@export var npc_resource: NPCResource

var power: int: set = set_power
var stamina: int: set = set_stamina

var experience: int:
    set(value):
        experience = max(value, 0)

        while experience >= level:
            experience -= level
            level += 1

var bond: int: set = set_bond


func _init(golfer_level := 1, golfer_role: Role = Role.new(), golfer_npc_resource: NPCResource = null):
    level = golfer_level
    role = golfer_role
    npc_resource = golfer_npc_resource

    power = 10
    stamina = 100
    experience = 0
    bond = 0


func set_power(new_power: int):
    power = max(new_power, 0)


func set_stamina(new_stamina: int):
    stamina = max(new_stamina, 0)


func set_bond(new_bond: int):
    bond = clamp(new_bond, 0, 100)
