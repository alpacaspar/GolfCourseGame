class_name GolfManager
extends Node3D


@export var golf_club_resource: Resource

@export var ball_scene: PackedScene
@export var fsm: FSM
@export var club: Node3D
@export var camera: Camera3D

var spawned_ball: Node3D
var current_angle: Vector3

var initialized: bool
var callback: Callable


func _initialize(_callback: Callable):
	initialized = false
	callback = _callback
	
	get_ball(get_ball_spawn_pos())
	spawned_ball._on_enter(self)
	
	await get_tree().create_timer(.1).timeout
	
	global_position = spawned_ball.position
	camera.current = true
	club.visible = true
	initialized = true
	
	fsm._transition_state($FSM/PickAngle)


func _on_process(_delta: float):
	if !initialized:
		return
	
	if Input.is_action_just_pressed("interact"):
		if fsm.current_state == $FSM/PickAngle:
			fsm._transition_state($FSM/Swing)
	
	if Input.is_action_just_pressed("cancel"):
		if fsm.current_state == $FSM/PickAngle:
			camera.clear_current()
			callback.call()
		else: if fsm.current_state == $FSM/Swing:
			fsm._transition_state($FSM/PickAngle)


func get_ball(_position: Vector3):
	if spawned_ball != null:
		return
	
	spawned_ball = ball_scene.instantiate()
	spawned_ball.position = _position
	get_tree().root.add_child(spawned_ball)


func remove_ball():
	if spawned_ball != null:
		spawned_ball.queue_free()
		spawned_ball = null


func hit_ball(speed : float):
	var remapped_speed = (golf_club_resource.max_speed - golf_club_resource.min_speed) * speed + golf_club_resource.min_speed
	if remapped_speed < golf_club_resource.speed_threshold:
		return
	
	current_angle += Vector3(0, golf_club_resource.vertical_amount, 0)
	spawned_ball._on_ball_hit(current_angle * remapped_speed)
	fsm._transition_state($FSM/BallFly, { "SpawnedBall" : spawned_ball })


func on_ball_stop():
	if !initialized:
		return
	
	await get_tree().create_timer(1.0).timeout
	
	fsm._transition_state($FSM/PickAngle)
	camera.clear_current()
	callback.call()
	initialized = false


func get_ball_spawn_pos() -> Vector3:
	var space_state = get_world_3d().direct_space_state
	var origin = global_position + Vector3(0, 1, 0)
	var end = origin + Vector3.DOWN * 2
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_areas = true

	var result = space_state.intersect_ray(query)
	
	return result.position + Vector3(0, .1, 0)


func get_can_play() -> bool:
	if initialized:
		return false
	
	if spawned_ball == null:
		return true
	
	if spawned_ball.global_position.distance_squared_to($"..".global_position) < 2 * 2:
		return true
	
	return false
