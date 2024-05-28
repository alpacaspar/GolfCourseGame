class_name Unit
extends CharacterBody3D


const ATTACK_ONESHOT_ANIM_PARAMETER: StringName = "parameters/AttackOneShot/request"
const HIT_ONE_SHOT: StringName = "parameters/HitOneShot/request"

@onready var visuals: Node = $Visuals

var team: Team

var golfer_resource: GolferResource
var role: Role:
	get:
		return golfer_resource.role

var character: Character
var animation_tree: AnimationTree
var controller: Node

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

var is_attacking := false


func _ready():
	BattleManager.on_battle_started.connect(_on_battle_manager_battle_started)


func _on_battle_manager_battle_started():
	controller.process_mode = PROCESS_MODE_INHERIT


func setup(new_golfer: GolferResource, assigned_team: Team, character_factory: Node):
	golfer_resource = new_golfer
	team = assigned_team

	controller.unit = self
	controller.process_mode = PROCESS_MODE_DISABLED

	character = character_factory.create_character(golfer_resource.npc_resource)
	visuals.add_child(character)

	if golfer_resource.role.primary_equipment:
		var equipment: Node3D = golfer_resource.role.primary_equipment.instantiate()
		equipment.owning_unit = self

		character.right_hand_marker.add_child(equipment)

	animation_tree = character.animation_tree

	character_factory.start_character_creation(character)
	character_factory.refresh_character(character)
	character_factory.override_shirt(character, assigned_team.team_resource.leader.npc_resource)
	await character_factory.end_character_creation(character)


func perform_action():
	animation_tree.set(ATTACK_ONESHOT_ANIM_PARAMETER, AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	role_action.perform()


func is_exhausted() -> bool:
	return golfer_resource.stamina <= 0


func take_damage(damage: int):
	golfer_resource.stamina -= damage

	if golfer_resource.stamina <= 0:
		golfer_resource.stamina = 0
		_exhaust()

	animation_tree.set(HIT_ONE_SHOT, AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)


func _exhaust():
	queue_free()
