extends Node3D


const MAX_SPEED = 5.0
const BLEND_SPEED = 10

const MOVE_BLEND_PARAMETER: StringName = "parameters/MoveBlend/blend_amount"
const RUN_SPEED_PARAMETER: StringName = "parameters/RunSpeed/scale"

@export var unit: Unit

var target_blend_value := 0.0

var rotation_dir := Vector3.ZERO
var last_position := Vector3.ZERO


func _ready():
    last_position = global_position


func _physics_process(delta: float):
    var velocity := (global_position - last_position).length() / delta
    var blend_value: float = min(velocity / MAX_SPEED, 1)

    target_blend_value = lerp(target_blend_value, blend_value, delta * BLEND_SPEED) 

    unit.animation_tree.set(MOVE_BLEND_PARAMETER, target_blend_value)
    unit.animation_tree.set(RUN_SPEED_PARAMETER, (1 - ((1 - target_blend_value) ** 2)) * 2)

    last_position = global_position


func look_in_direction(direction: Vector3):
    var target := atan2(direction.x, direction.z) - rotation.y
    rotation.y = lerp_angle(rotation.y, target, 8 * get_physics_process_delta_time())
