extends RigidBody3D


var golf_action: Node3D
var was_hit: bool


func _on_enter(_golf_action: Node3D):
	golf_action = _golf_action
	sleeping = true


func _physics_process(_delta: float):
	if was_hit:
		await get_tree().create_timer(.2).timeout
		was_hit = false
	
	if sleeping:
		return
	
	if linear_velocity.length_squared() < .3 * .3:
		golf_action.on_ball_stop()
		sleeping = true


func _on_ball_hit(givenHitDirection: Vector3):
	was_hit = true
	
	apply_impulse(givenHitDirection)
