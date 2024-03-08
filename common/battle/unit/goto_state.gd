extends State


const MAX_INSTANT_PATHFINDING_DISTANCE = 20
const DISTANCE_TOLERANCE = 0.5

@onready var pathfinding_interval_timer: Timer = $PathfindingIntervalTimer

@export var ai_controller: Node3D

var target: Node3D


func _on_enter(msg := {}):
	target = msg.target
	
	_on_pathfinding_interval_timer_timeout()
	pathfinding_interval_timer.timeout.connect(_on_pathfinding_interval_timer_timeout)
	# TODO: Change to non-random interval.
	# To avoid all AI agents pathfinding at the same time, delay the start of the timer by a random amount.
	await get_tree().create_timer(randf_range(0, 3)).timeout
	pathfinding_interval_timer.start()



func _on_physics_process(_delta):
	if target:
		var distance_squared := target.global_position.distance_squared_to(ai_controller.global_position)
		var desired_distance: float = ai_controller.body.golfer_resource.role.desired_distance - DISTANCE_TOLERANCE
		if distance_squared < desired_distance * desired_distance:
			fsm_owner.transition_to("AttackState", { "target": target })
			return

		if distance_squared < MAX_INSTANT_PATHFINDING_DISTANCE * MAX_INSTANT_PATHFINDING_DISTANCE:
			_on_pathfinding_interval_timer_timeout()


func _on_pathfinding_interval_timer_timeout():
	if target:
		ai_controller.set_movement_target(target.global_position)


func _on_exit():
	pathfinding_interval_timer.stop()
	pathfinding_interval_timer.timeout.disconnect(_on_pathfinding_interval_timer_timeout)