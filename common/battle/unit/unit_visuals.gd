extends Node3D


const BLEND_SPEED = 10.0
const RUN_BLEND_PARAMETER := "parameters/MoveBlend/blend_amount"

@export var body: PhysicsBody3D

var rotation_dir := Vector3.ZERO
var run_blend_value := 0.0


func _process(delta: float):
	if body.velocity:
		rotation_dir = Vector3(body.velocity.x, global_position.y, body.velocity.z)
	
	var angle := atan2(rotation_dir.x, rotation_dir.z)
	global_rotation.y = lerp_angle(global_rotation.y, angle, delta * BLEND_SPEED)

	run_blend_value = lerp(run_blend_value, min(body.velocity.length(), 1.0), delta * BLEND_SPEED)
	body.animation_tree.set(RUN_BLEND_PARAMETER, run_blend_value)
