extends RigidBody3D


const VELOCITY_DAMAGE_THRESHOLD = 1.0

var owning_unit: Unit


func _on_body_entered(body: Node) -> void:
    if not body is Unit:
        return

    if body == owning_unit:
        return

    if body.team == owning_unit.team:
        return
    
    if body.linear_velocity.length_squared() < VELOCITY_DAMAGE_THRESHOLD ** 2:
        return

    if body.has_method("take_damage"):
        body.take_damage(owning_unit.golfer_resource.power)
        # Allow only one hit per ball.
        contact_monitor = false
