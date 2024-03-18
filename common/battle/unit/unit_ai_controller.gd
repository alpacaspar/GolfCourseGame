extends Node3D


const DETECTION_RADIUS_PADDING = 5

@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D
@onready var behaviour_tree: BehaviourTree = $BehaviourTree

var body: CharacterBody3D


func _ready():
	navigation_agent.velocity_computed.connect(_on_velocity_computed)
	behaviour_tree.blackboard["controller"] = self
	behaviour_tree.blackboard["golfer"] = body.golfer_resource


func _physics_process(delta):
	behaviour_tree.tick_tree(delta)


# Signal function
func _on_velocity_computed(safe_velocity: Vector3):
	body.velocity = safe_velocity
	body.move_and_slide()


func give_commands(target_position: Vector3, target_formation: Formation):
	behaviour_tree.blackboard["target_position"] = target_position
	behaviour_tree.blackboard["target_formation"] = target_formation


## Set a new movement target for the agent to pathfind to.
func set_movement_target(movement_target: Vector3):
	navigation_agent.set_target_position(movement_target)
