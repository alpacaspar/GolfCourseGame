class_name GolfManager
extends Node3D


@export var ballScene : PackedScene
@export var fsm : FSM
@export var club : Node3D

var spawnedBall
var currentAngle : Vector3


func _ready():
	spawn_ball()
	club.visible = true


func _process(delta):
	cycle_states();


func cycle_states():
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


func spawn_ball():
	var ball = ballScene.instantiate()
	add_child(ball);
	
	spawnedBall = ball


func hit_ball(speed : float):
	spawnedBall._on_ball_hit((currentAngle * 10) + Vector3(0, 1, 0) * (speed / 10))
