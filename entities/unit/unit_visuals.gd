extends Node3D


const BLEND_SPEED = 10
const MOVE_BLEND_PARAMETER: StringName = "parameters/MoveBlend/blend_amount"
const RUN_SPEED_PARAMETER: StringName = "parameters/RunSpeed/scale"

@export var body: CharacterBody3D

var target_blend_value := 0.0

var rotation_dir := Vector3.ZERO
var last_position := Vector3.ZERO


func _ready():
    last_position = global_position


func _physics_process(delta: float):
    var velocity := (global_position - last_position).length() / delta
    var blend_value: float = min(velocity / body.MOVE_SPEED, 1)

    target_blend_value = lerp(target_blend_value, blend_value, delta * BLEND_SPEED) 

    body.animation_tree.set(MOVE_BLEND_PARAMETER, target_blend_value)
    body.animation_tree.set(RUN_SPEED_PARAMETER, target_blend_value * 2)

    last_position = global_position


func look_in_direction(target: Vector3, delta: float):
    rotation_dir = Vector3(target.x, global_position.y, target.z)

    var angle := atan2(rotation_dir.x, rotation_dir.z)
    global_rotation.y = lerp_angle(global_rotation.y, angle, delta * BLEND_SPEED)
