class_name Unit
extends CharacterBody3D


const ATTACK_ONESHOT_ANIM_PARAMETER: StringName = "parameters/AttackOneShot/request"
const BLOCK_BLEND_ANIM_PARAMETER = "parameters/BlockBlend/blend_amount"
const BLOCK_TIME_SEEK_ANIM_PARAMETER = "parameters/BlockTimeSeek/seek_request"
const BLOCK_TWEEN_DURATION = 0.2
const HIT_ONE_SHOT_ANIM_PARAMETER: StringName = "parameters/HitOneShot/request"

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
var is_blocking := false

var move_speed:
    get:
        if is_blocking:
            return role.block_move_speed
        
        return role.move_speed


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


func perform_attack():
	animation_tree.set(ATTACK_ONESHOT_ANIM_PARAMETER, AnimationNodeOneShot.ONE_SHOT_REQUEST_FADE_OUT)
	animation_tree.set(ATTACK_ONESHOT_ANIM_PARAMETER, AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)


func perform_block():
	var tween := create_tween()
	tween.tween_property(animation_tree, BLOCK_BLEND_ANIM_PARAMETER, 1.0, BLOCK_TWEEN_DURATION)
	animation_tree.set(BLOCK_TIME_SEEK_ANIM_PARAMETER, 0.0)

	is_blocking = true


func cancel_block():
	var tween := create_tween()
	tween.tween_property(animation_tree, BLOCK_BLEND_ANIM_PARAMETER, 0.0, BLOCK_TWEEN_DURATION)
	animation_tree.set(BLOCK_TIME_SEEK_ANIM_PARAMETER, -1.0)

	is_blocking = false


func is_exhausted() -> bool:
	return golfer_resource.stamina <= 0


func try_take_damage(attacker: Unit, damage: int) -> bool:
	if attacker.team == team:
		return false

	var direction_to_attacker: Vector3 = global_position.direction_to(Vector3(attacker.global_position.x, global_position.y, attacker.global_position.z))
	var angle := global_basis.z.angle_to(direction_to_attacker)
	if is_blocking and rad_to_deg(angle) < 30.0:
		return false

	golfer_resource.stamina -= damage

	if golfer_resource.stamina <= 0:
		golfer_resource.stamina = 0
		_exhaust()

	animation_tree.set(HIT_ONE_SHOT_ANIM_PARAMETER, AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)

	return true


func _exhaust():
	queue_free()
