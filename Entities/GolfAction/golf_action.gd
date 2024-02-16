class_name GolfManager
extends Node3D


@export var ballScene : PackedScene
@export var fsm : FSM
@export var club : Node3D

var spawnedBall
var currentAngle : Vector3

var initialized : bool
var callback


func _initialize(_callback):
	initialized = false
	get_ball()
	spawnedBall._on_enter(self)
	callback = _callback
	
	await get_tree().create_timer(1.0).timeout
	global_position = spawnedBall.position
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


func get_ball():
	if spawnedBall != null:
		return
	
	spawnedBall = ballScene.instantiate()
	spawnedBall.position = global_position
	get_tree().root.add_child(spawnedBall)


func hit_ball(speed : float):
	spawnedBall._on_ball_hit((currentAngle * 10) + Vector3(0, 1, 0) * (speed / 10))


func on_ball_stop():
	if !initialized:
		return
	
	prints("stopped")
	fsm._transition_state($FSM/NoGame)
	callback.call()
