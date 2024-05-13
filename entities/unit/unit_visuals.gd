extends Node3D


const BLEND_SPEED = 10
const MOVE_BLEND_PARAMETER: StringName = "parameters/MoveBlend/blend_amount"
const RUN_SPEED_PARAMETER: StringName = "parameters/RunSpeed/scale"

@export var body: CharacterBody3D

var rotation_dir := Vector3.ZERO
var move_blend_value := 0.0


func _physics_process(delta: float):
	var target_blend_value := 0.0

	target_blend_value = 1.0 if body.velocity.length_squared() > 0.5 * 0.5 else 0.0

	move_blend_value = lerp(move_blend_value, target_blend_value, delta * BLEND_SPEED)
	body.animation_tree.set(MOVE_BLEND_PARAMETER, move_blend_value)
	body.animation_tree.set(RUN_SPEED_PARAMETER, body.velocity.length() / body.MOVEMENT_SPEED * 2)


func look_in_direction(target: Vector3, delta: float):
	rotation_dir = Vector3(target.x, global_position.y, target.z)
	
	var angle := atan2(rotation_dir.x, rotation_dir.z)
	global_rotation.y = lerp_angle(global_rotation.y, angle, delta * BLEND_SPEED)
