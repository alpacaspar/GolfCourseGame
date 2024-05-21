class_name Unit
extends CharacterBody3D


const ACTION_TRANSITION_ANIM_PARAMETER: StringName = "parameters/Transition/transition_request"
const HIT_ONE_SHOT: StringName = "parameters/HitOneShot/request"

const MOVE_SPEED = 6.0

@onready var visuals: Node = $Visuals

var team: Team

var golfer_resource: GolferResource
var role: Role:
    get:
        return golfer_resource.role

var character: Character
var animation_tree: AnimationTree
var controller: Node
var role_action: Node

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

var target: Node3D
## The amount of units that are targeting this unit.
var targeting_units: Array[Unit] = []

var state := IDLE


func setup(new_golfer: GolferResource, assigned_team: Team):
    golfer_resource = new_golfer
    team = assigned_team

    controller.unit = self

    character = CharacterFactory.spawn_character(golfer_resource.npc_resource)
    visuals.add_child(character)

    role_action = golfer_resource.role.primary_action.instantiate()
    add_child(role_action)

    if golfer_resource.role.primary_equipment:
        var equipment: Node3D = golfer_resource.role.primary_equipment.instantiate()
        equipment.owning_unit = self

        character.right_hand_marker.add_child(equipment)

    animation_tree = character.animation_tree
    character.animation_tree.tree_root = golfer_resource.role.animation_blend_tree


func perform_action():
    animation_tree.set(ACTION_TRANSITION_ANIM_PARAMETER, "start_action")
    role_action.perform()


func is_exhausted() -> bool:
    return golfer_resource.stamina <= 0


func take_damage(damage: int):
    golfer_resource.stamina -= damage

    if golfer_resource.stamina <= 0:
        golfer_resource.stamina = 0
        _exhaust()
    
    animation_tree.set(HIT_ONE_SHOT, AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
    animation_tree.set(ACTION_TRANSITION_ANIM_PARAMETER, "input")


func _exhaust():
    queue_free()


func start_targeting(targeting: Unit):
    targeting_units.append(targeting)


func stop_targeting(targeting: Unit):
    targeting_units.erase(targeting)


func get_target_amount() -> int:
    return targeting_units.size()


enum { IDLE, ATTACKING }
