extends RigidBody3D


@export var camera : Camera3D

var hitDirection
var wasHit 
var golf_action


func _init(_golf_action):
	golf_action = _golf_action


func _physics_process(_delta):
	if sleeping:
		return
	
	if linear_velocity.length() < 1:
		sleeping = true


func _on_ball_hit(givenHitDirection : Vector3):
	hitDirection = givenHitDirection
	wasHit = true
	
	apply_impulse(givenHitDirection)
	camera.current = true
