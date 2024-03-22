extends Node3D


const DETECTION_RADIUS_PADDING = 5

@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D
@onready var behaviour_tree: BehaviourTree = $BehaviourTree

var body: CharacterBody3D

var initialized := false


func _ready():
	navigation_agent.velocity_computed.connect(_on_velocity_computed)
	navigation_agent.target_desired_distance = body.golfer_resource.role.desired_distance

	behaviour_tree.blackboard["unit"] = body

	wait_for_initialization()


func _physics_process(delta):
	if initialized:
		behaviour_tree.process_tree(delta)


# Signal function
func _on_velocity_computed(safe_velocity: Vector3):
	body.velocity = safe_velocity
	body.move_and_slide()


func give_command(target_formation: Node3D):
	behaviour_tree.blackboard["target_formation"] = target_formation


## Set a new movement target for the agent to pathfind to.
func set_movement_target(movement_target: Vector3):
	navigation_agent.set_target_position(movement_target)


func wait_for_initialization():
	await get_tree().create_timer(3).timeout

	initialized = true