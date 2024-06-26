extends Node


const BUFFER_SIZE = 5

var buffer_target: CharacterBody3D

var velocity_buffer := PackedVector3Array()
var average_velocity: Vector3:
    get:
        var sum := Vector3.ZERO
        for velocity: Vector3 in velocity_buffer:
            sum += velocity

        return sum / velocity_buffer.size()


func _ready():
    velocity_buffer.resize(BUFFER_SIZE)
    buffer_target = get_parent()


func _physics_process(_delta: float):
    # Shift the buffer values.
    for i: int in range(BUFFER_SIZE - 1):
        velocity_buffer[i + 1] = velocity_buffer[i]
    
    # Add the current velocity to the buffer.
    velocity_buffer[0] = buffer_target.get_real_velocity()
