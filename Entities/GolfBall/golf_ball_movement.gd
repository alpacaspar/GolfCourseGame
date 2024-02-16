extends RigidBody3D


var golf_action
var was_hit


func _on_enter(_golf_action):
	golf_action = _golf_action
	was_hit = true


func _physics_process(_delta):
	if was_hit:
		await get_tree().create_timer(.2).timeout
		was_hit = false
	
	if sleeping:
		return
	
	if linear_velocity.length() < .3:
		golf_action.on_ball_stop()
		sleeping = true


func _on_ball_hit(givenHitDirection : Vector3):
	was_hit = true
	
	apply_impulse(givenHitDirection)
