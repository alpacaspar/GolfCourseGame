extends RigidBody3D


var golf_action
var wasHit


func _on_enter(_golf_action):
	golf_action = _golf_action
	wasHit = true


func _physics_process(_delta):
	if wasHit:
		await get_tree().create_timer(1.0).timeout
		wasHit = false
	
	if sleeping:
		return
	
	if linear_velocity.length() < .3:
		sleeping = true


func _on_ball_hit(givenHitDirection : Vector3):
	wasHit = true
	
	apply_impulse(givenHitDirection)
	print_debug("Runs")
