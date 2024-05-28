extends RigidBody3D


const VELOCITY_DAMAGE_THRESHOLD = 1.0

var owning_unit: Unit


func _on_body_entered(body: Node) -> void:
    if not body is Unit:
        return

    if linear_velocity.length_squared() < VELOCITY_DAMAGE_THRESHOLD ** 2:
        return

    if body.has_method("try_take_damage"):
        body.try_take_damage(owning_unit, owning_unit.golfer_resource.power)
        # Allow only one hit per ball.
        self.set_deferred("contact_monitor", false)


func _on_timer_timeout():
    queue_free()
