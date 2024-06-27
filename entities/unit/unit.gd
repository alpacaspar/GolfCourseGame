class_name Unit
extends CharacterBody3D


const ATTACK_ONESHOT_ANIM_PARAMETER: StringName = "parameters/AttackOneShot/request"
const KNOCKOUT_ONESHOT_ANIM_PARAMETER: StringName = "parameters/StaminaTransition/transition_request"
const BLOCK_BLEND_ANIM_PARAMETER = "parameters/BlockBlend/blend_amount"
const BLOCK_TIME_SEEK_ANIM_PARAMETER = "parameters/BlockTimeSeek/seek_request"
const BLOCK_TWEEN_DURATION = 0.2
const HIT_ONE_SHOT_ANIM_PARAMETER: StringName = "parameters/HitOneShot/request"

@export_flags_3d_physics var sensor_collision_mask := 2

@onready var character_container: Node = $CharacterContainer
@onready var velocity_buffer: Node = $VelocityBuffer
@onready var collision_shape: CollisionShape3D = $CollisionShape3D

var team: Team

var golfer_resource: GolferResource
var role: Role:
	get:
		return golfer_resource.role

var character: Character
var animation_tree: AnimationTree
var controller: Node3D

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

var is_attacking := false
var is_blocking := false

var attack_tween: Tween

var move_speed: float:
	get:
		if is_attacking:
			return 0.0

		if is_blocking:
			return role.block_move_speed
		
		return role.move_speed


func _ready():
	BattleManager.on_battle_started.connect(_on_battle_manager_battle_started)


func _physics_process(_delta: float):
	if not attack_tween == null and attack_tween.is_running():
		move_and_slide()


func _on_battle_manager_battle_started():
	controller.process_mode = PROCESS_MODE_INHERIT


func setup(new_golfer: GolferResource, assigned_team: Team, character_factory: Node):
	golfer_resource = new_golfer
	team = assigned_team

	controller.unit = self
	controller.process_mode = PROCESS_MODE_DISABLED

	character = character_factory.create_character(golfer_resource.npc_resource)
	character_container.add_child(character)

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

	var target_velocity := _get_attack_direction() * role.move_speed
	target_velocity.y = velocity.y
	attack_tween = create_tween()
	attack_tween.tween_interval(0.4)
	attack_tween.tween_property(self, "velocity", target_velocity, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUART)


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


func try_take_damage(attack_origin: Node3D, team_origin: Team, damage: int) -> bool:
	if team == team_origin:
		return false

	var direction_to_attacker: Vector3 = global_position.direction_to(Vector3(attack_origin.global_position.x, global_position.y, attack_origin.global_position.z))
	var angle := controller.global_basis.z.angle_to(direction_to_attacker)
	if is_blocking and rad_to_deg(angle) < 60.0:
		return false

	golfer_resource.stamina -= damage

	if golfer_resource.stamina <= 0:
		golfer_resource.stamina = 0
		_exhaust()

	animation_tree.set(HIT_ONE_SHOT_ANIM_PARAMETER, AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)

	return true


func _exhaust():
	animation_tree.set(KNOCKOUT_ONESHOT_ANIM_PARAMETER, "knocked_out")
	call_deferred("disable_unit")


func disable_unit():
	controller.process_mode = PROCESS_MODE_DISABLED
	collision_shape.disabled = true

	await get_tree().create_timer(3.0).timeout

	process_mode = PROCESS_MODE_DISABLED


func _get_query(query_radius: float) -> PhysicsShapeQueryParameters3D:
	var shape_rid := PhysicsServer3D.sphere_shape_create()
	PhysicsServer3D.shape_set_data(shape_rid, query_radius)

	var params := PhysicsShapeQueryParameters3D.new()
	params.shape_rid = shape_rid
	params.transform = global_transform
	params.collision_mask = sensor_collision_mask

	params.exclude = [self.get_rid()]

	return params


func _get_attack_direction() -> Vector3:
	var space_state := get_world_3d().direct_space_state
	var query := _get_query(role.attack_range)
	var intersections: Array[Dictionary] = space_state.intersect_shape(query)

	var most_forward_dot := -1.0
	var most_forward_direction := Vector3.ZERO

	for intersection: Dictionary in intersections:
		var intersected_entity: Node3D = intersection["collider"]
		if intersected_entity.is_in_group("unit") or intersected_entity.is_in_group("ball"):
			var direction_to := global_position.direction_to(Vector3(intersected_entity.global_position.x, global_position.y, intersected_entity.global_position.z))
			var dot := controller.global_basis.z.dot(direction_to)

			if dot > most_forward_dot:
				most_forward_dot = dot
				most_forward_direction = direction_to
	
	return most_forward_direction
