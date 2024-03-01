class_name Golfer
extends CharacterBody3D
## Base class for all golferbodies.
##
## GolferResource Bodies will be spawned in battle.
## The inherited [b]Golfer[/b] should be assigned to it's respective [Role] resource.


const MOVEMENT_SPEED = 5.0

@export var search_type: SearchType
@export var desired_distance: float = 10.0

@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D
@onready var detection_area: DetectionArea3D = $DetectionArea3D

var golfer_resource: GolferResource
var leader_resource: RivalResource

var target: Golfer

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")


func _ready():
    navigation_agent.path_desired_distance = desired_distance
    
    navigation_agent.velocity_computed.connect(_on_velocity_computed)


func set_target(new_target: Golfer):
    self.target = new_target


func set_movement_target_position(movement_target: Vector3):
    navigation_agent.set_target_position(movement_target)


func _physics_process(delta):
    if target:
        set_movement_target_position(target.global_position)

    var wish_dir := Vector3.ZERO


    wish_dir += separate_from(global_position, detection_area.overlapping_character_positions)

    if !navigation_agent.is_navigation_finished():
        var next_path_position := navigation_agent.get_next_path_position()
        wish_dir += global_position.direction_to(next_path_position)

    var new_velocity = wish_dir.normalized() * MOVEMENT_SPEED
    new_velocity.y = -1 if is_on_floor() else new_velocity.y - gravity * delta

    if navigation_agent.avoidance_enabled:
        navigation_agent.set_velocity(new_velocity)
    else:
        _on_velocity_computed(new_velocity)


func _on_velocity_computed(safe_velocity: Vector3):
    velocity = safe_velocity
    move_and_slide()


func setup(new_golfer: GolferResource, new_leader: RivalResource, spawn_position: Vector3):
    golfer_resource = new_golfer
    leader_resource = new_leader
    transform.origin = spawn_position


func is_exhausted() -> bool:
    return golfer_resource.stamina <= 0


func separate_from(origin: Vector3, target_positions: Array[Vector3]) -> Vector3:
    var separation := Vector3.ZERO

    for target_position in target_positions:
        separation -= origin.direction_to(target_position)

    return separation.normalized()


enum SearchType {
	OPPONENT,
	TEAMMATE,
}
