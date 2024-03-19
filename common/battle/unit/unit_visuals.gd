extends Node3D


const BLEND_SPEED = 10
const MOVE_BLEND_PARAMETER: StringName = "parameters/MoveBlend/blend_amount"
const SWING_CONDITION: StringName = "parameters/SwingOneShot/request"

@export var body: CharacterBody3D

var rotation_dir := Vector3.ZERO
var move_blend_value := 0.0


func _ready():
	body.on_swing_performed.connect(_on_swing_performed)


func _physics_process(delta: float):
	var target_blend_value := 0.0

	if body.velocity.length() > 0.5:
		target_blend_value = 1.0
	else:
		target_blend_value = 0.0

	move_blend_value = lerp(move_blend_value, target_blend_value, delta * BLEND_SPEED)
	body.animation_tree.set(MOVE_BLEND_PARAMETER, move_blend_value)


func look_in_dir(target: Vector3, delta: float):
	rotation_dir = Vector3(target.x, global_position.y, target.z)
	
	var angle := atan2(rotation_dir.x, rotation_dir.z)
	global_rotation.y = lerp_angle(global_rotation.y, angle, delta * BLEND_SPEED)


func _on_swing_performed():
	body.animation_tree.set(SWING_CONDITION, AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
