extends Node3D


@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D
@onready var behaviour_tree: BehaviourTree = $BehaviourTree

# Set when the controller is created by the BattleManager.
var unit: Unit


func _ready():
    navigation_agent.velocity_computed.connect(_on_velocity_computed)

    behaviour_tree.blackboard["unit"] = unit


func _physics_process(delta: float):
    behaviour_tree.process_tree(delta)


# Signal function
func _on_velocity_computed(safe_velocity: Vector3):
    unit.velocity = safe_velocity
    unit.move_and_slide()


## Set a new movement target for the agent to pathfind to.
func set_movement_target(movement_target: Vector3):
    navigation_agent.set_target_position(movement_target)


func set_velocity(new_velocity: Vector3):
    if navigation_agent.avoidance_enabled:
        navigation_agent.set_velocity(new_velocity)
    else:
        unit.controller._on_velocity_computed(new_velocity)
