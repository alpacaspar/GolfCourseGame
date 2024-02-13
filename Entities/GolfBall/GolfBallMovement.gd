extends RigidBody3D


var hitDirection
var wasHit 


func _ready():
	pass


func _process(_delta):
	if (Input.is_action_just_pressed("TestKey")):
		_on_ball_hit(Vector3(1, 1, 0) * 10)


func _physics_process(_delta):
	if sleeping:
		return
	
	if linear_velocity.length() < 1:
		print_debug("Runs")
		sleeping = true


func _on_ball_hit(givenHitDirection : Vector3):
	hitDirection = givenHitDirection
	wasHit = true
	
	apply_impulse(givenHitDirection)
