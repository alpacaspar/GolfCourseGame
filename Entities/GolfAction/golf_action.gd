class_name GolfManager
extends Node3D


@export var ballScene : PackedScene
@export var fsm : FSM
@export var club : Node3D

var spawnedBall
var currentAngle : Vector3


func _initialize():
	get_ball()
	spawnedBall._on_enter(self)
	club.visible = true
	
	await get_tree().create_timer(1.0).timeout
	position = spawnedBall.position


func _on_process(delta):
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


func get_ball():
	if spawnedBall != null:
		return
	
	spawnedBall = ballScene.instantiate()
	spawnedBall.position = position
	get_tree().root.add_child(spawnedBall)


func hit_ball(speed : float):
	spawnedBall._on_ball_hit((currentAngle * 10) + Vector3(0, 1, 0) * (speed / 10))
