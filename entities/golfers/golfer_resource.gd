class_name GolferResource
extends Resource


signal on_stamina_changed(stamina: int)


@export var level := 1
@export var role := Role.new()

@export var npc_resource: NPCResource

var power: int: get = get_power
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

	stamina = level + role.base_stamina

	experience = 0
	bond = 0


func get_power() -> int:
	return level + role.base_power


func set_stamina(new_stamina: int):
	if new_stamina == stamina:
		return

	stamina = max(new_stamina, 0)
	on_stamina_changed.emit(stamina)


func set_bond(new_bond: int):
	bond = clamp(new_bond, 0, 100)
