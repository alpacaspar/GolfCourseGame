extends Node3D




@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D
@onready var detection_area: DetectionArea3D = $DetectionArea3D


var body: CharacterBody3D


func _ready():
	navigation_agent.path_desired_distance = body.golfer_resource.role.desired_distance
	
	navigation_agent.velocity_computed.connect(_on_velocity_computed)


func _physics_process(delta):
	var wish_dir := Vector3.ZERO
	
	wish_dir += separate_from(body.global_position, detection_area.overlapping_character_positions) * 0.02
	
	if not navigation_agent.is_navigation_finished():
		var next_path_position := navigation_agent.get_next_path_position()
		wish_dir += body.global_position.direction_to(next_path_position)
	
	var new_velocity = wish_dir.normalized() * body.MOVEMENT_SPEED
	new_velocity.y = -1 if body.is_on_floor() else new_velocity.y - body.gravity * delta
	
	if navigation_agent.avoidance_enabled:
		navigation_agent.set_velocity(new_velocity)
	else:
		_on_velocity_computed(new_velocity)


# Signal function
func _on_velocity_computed(safe_velocity: Vector3):
	body.velocity = safe_velocity
	body.move_and_slide()


func set_movement_target(movement_target: Vector3):
	navigation_agent.set_target_position(movement_target)


func separate_from(origin: Vector3, target_positions: Array[Vector3]) -> Vector3:
	var separation := Vector3.ZERO
	
	for target_position in target_positions:
		separation -= origin.direction_to(target_position)
	
	separation.y = 0
	return separation.normalized()
