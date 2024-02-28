class_name GolferBody
extends CharacterBody3D
## Base class for all golferbodies.
##
## Golfer Bodies will be spawned in battle.
## The inherited [b]GolferBody[/b] should be assigned to it's respective [Role] resource.


const MOVEMENT_SPEED = 5.0

@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D

var golfer: Golfer
var leader: Rival

var target: GolferBody


func _ready():
    navigation_agent.velocity_computed.connect(_on_velocity_computed)


func set_movement_target(movement_target: Vector3):
    navigation_agent.set_target_position(movement_target)


func _physics_process(_delta):
    if navigation_agent.is_navigation_finished():
        return

    var next_path_position := navigation_agent.get_next_path_position()
    var new_velocity := global_position.direction_to(next_path_position) * MOVEMENT_SPEED
    if navigation_agent.avoidance_enabled:
        navigation_agent.set_velocity(new_velocity)
    else:
        _on_velocity_computed(new_velocity)


func _on_velocity_computed(safe_velocity: Vector3):
    velocity = safe_velocity
    move_and_slide()


func setup(new_golfer: Golfer, new_leader: Rival, spawn_position: Vector3):
    golfer = new_golfer
    leader = new_leader
    transform.origin = spawn_position


func is_exhausted() -> bool:
    return golfer.stamina <= 0
