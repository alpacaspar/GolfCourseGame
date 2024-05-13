extends Node3D


const DETECTION_RADIUS_PADDING = 5

@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D

@export var behaviour_tree_scene: Dictionary = {}

var behaviour_tree: BehaviourTree
# Set when the controller is created by the BattleManager.
var unit: Unit


func _ready():
	navigation_agent.velocity_computed.connect(_on_velocity_computed)
	navigation_agent.target_desired_distance = unit.golfer_resource.role.desired_distance

	behaviour_tree = behaviour_tree_scene[unit.golfer_resource.role].instantiate()
	add_child(behaviour_tree)

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
