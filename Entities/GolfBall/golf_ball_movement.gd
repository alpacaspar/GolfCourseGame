extends RigidBody3D


var hitDirection
var wasHit 


func _ready():
	pass


func _physics_process(_delta):
	if sleeping:
		return
	
	if linear_velocity.length() < 1:
		sleeping = true


func _on_ball_hit(givenHitDirection : Vector3):
	hitDirection = givenHitDirection
	wasHit = true
	
	apply_impulse(givenHitDirection)
