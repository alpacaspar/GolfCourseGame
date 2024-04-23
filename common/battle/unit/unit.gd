class_name Unit
extends CharacterBody3D


const MOVEMENT_SPEED = 6.0

@onready var visuals: Node = $Visuals
@onready var primary_action: Node = $PrimaryAction

var team: Team

var golfer_resource: GolferResource
var role: Role:
    get:
        return golfer_resource.role

var animation_tree: AnimationTree
var controller: Node

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

## The amount of units that are targetting this unit.
var targeting_units: Array[Unit] = []


func setup(new_golfer: GolferResource, assigned_team: Team):
    golfer_resource = new_golfer
    team = assigned_team

    controller.unit = self

    var character: Character = CharacterFactory.spawn_character(golfer_resource.npc_resource)
    visuals.add_child(character)

    if golfer_resource.role.primary_equipment:
        var equipment: Node3D = golfer_resource.role.primary_equipment.instantiate()
        equipment.owning_unit = self

        character.primary_equipment_slot.add_child(equipment)

    animation_tree = character.animation_tree
    character.animation_tree.tree_root.get_node("ACTION").animation = golfer_resource.role.primary_animation


func perform_action():
    primary_action.perform(self)


func is_exhausted() -> bool:
    return golfer_resource.stamina <= 0


func take_damage(damage: int):
    golfer_resource.stamina -= damage

    if golfer_resource.stamina <= 0:
        golfer_resource.stamina = 0
        _exhaust()


func _exhaust():
    queue_free()


func start_targeting(targeting: Unit):
    targeting_units.append(targeting)


func stop_targeting(targeting: Unit):
    targeting_units.erase(targeting)


func get_target_amount() -> int:
    return targeting_units.size()
