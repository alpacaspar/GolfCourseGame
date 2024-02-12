extends Marker3D


const MAX_DISTANCE = 6

@onready var camera_raycast = $CameraRayCast
@onready var camera = $PlayerCamera

var target_position : Vector3


func _physics_process(delta):
	var distance = MAX_DISTANCE
	
	if camera_raycast.is_colliding():
		distance = (camera_raycast.get_collision_point() - global_position).length()
		distance = clamp(distance, 0, MAX_DISTANCE)
	
	camera.position = -Vector3.FORWARD * distance
