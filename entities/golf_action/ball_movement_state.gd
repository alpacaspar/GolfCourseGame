extends State


@export var ball_cam : Camera3D
@export var golf_cam : Camera3D

var spawned_ball
var sequence_over


func _on_enter(_owner : FSM, _args = {}):
	sequence_over = false
	spawned_ball = _args["SpawnedBall"]
	
	ball_cam.global_position = golf_cam.global_position
	ball_cam.current = true
	
	look_at_sequence()


func _on_input(_event, _owner : FSM):
	pass


func _on_process(_delta, _owner : FSM):
	pass


func _on_physics_process(_delta, _owner : FSM):
	ball_cam.look_at(spawned_ball.global_position)
	
	if !sequence_over:
		return
	
	if ball_cam.global_position.distance_to(spawned_ball.global_position) > 10:
		ball_cam.global_position = spawned_ball.global_position + Vector3(0, 3, 0)


func _on_exit(_args = {}):
	pass


func look_at_sequence():
	await get_tree().create_timer(1.0).timeout
	ball_cam.global_position = get_camera_pos()
	
	await get_tree().create_timer(3.0).timeout
	ball_cam.global_position = spawned_ball.global_position + Vector3(0, 3, 0)
	sequence_over = true


func get_camera_pos() -> Vector3:
	var space_state = spawned_ball.get_world_3d().direct_space_state
	var origin = spawned_ball.global_position
	var end = origin + Vector3.DOWN * 50
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_areas = true

	var result = space_state.intersect_ray(query)
	
	return result.position + Vector3(0, .3, 0)
