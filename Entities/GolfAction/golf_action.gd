class_name GolfManager
extends Node3D


@export var ball_scene : PackedScene
@export var fsm : FSM
@export var club : Node3D
@export var camera : Camera3D

var spawned_ball
var current_angle : Vector3

var initialized : bool
var callback


func _initialize(_callback):
	initialized = false
	callback = _callback
	
	get_ball(get_ball_spawn_pos())
	spawned_ball._on_enter(self)
	
	await get_tree().create_timer(1.0).timeout
	
	global_position = spawned_ball.position
	camera.current = true
	club.visible = true
	initialized = true


func _on_process(_delta):
	if !initialized:
		return
	
	if Input.is_action_just_pressed("Mouse0"):
		if fsm.current_state == $FSM/NoGame:
			fsm._transition_state($FSM/PickAngle)
		else: if fsm.current_state == $FSM/PickAngle:
			fsm._transition_state($FSM/Swing)
	
	if Input.is_action_just_pressed("Mouse1"):
		if fsm.current_state == $FSM/PickAngle:
			fsm._transition_state($FSM/NoGame)
		else: if fsm.current_state == $FSM/Swing:
			fsm._transition_state($FSM/PickAngle)


func get_ball(_position):
	if spawned_ball != null:
		return
	
	spawned_ball = ball_scene.instantiate()
	spawned_ball.position = _position
	get_tree().root.add_child(spawned_ball)


func hit_ball(speed : float):
	spawned_ball._on_ball_hit((current_angle * 10) + Vector3(0, 1, 0) * (speed / 10))
	fsm._transition_state($FSM/BallFly, { "SpawnedBall" : spawned_ball })


func on_ball_stop():
	if !initialized:
		return
	
	fsm._transition_state($FSM/NoGame)
	callback.call()


func get_ball_spawn_pos() -> Vector3:
	var space_state = get_world_3d().direct_space_state
	var origin = global_position
	var end = origin + Vector3.DOWN * 2
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_areas = true

	var result = space_state.intersect_ray(query)
	
	return result.position + Vector3(0, .1, 0)
