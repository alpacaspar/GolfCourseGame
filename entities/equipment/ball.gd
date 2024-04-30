extends RigidBody3D


const VELOCITY_DAMAGE_THRESHOLD = 10.0

var owning_unit: Unit


func _on_body_entered(unit: Node3D):
    if linear_velocity.length_squared() < VELOCITY_DAMAGE_THRESHOLD ** 2:
        return

    if not unit is Unit:
        return

    if unit == owning_unit:
        return

    if unit.team == owning_unit.team:
        return

    if unit.has_method("take_damage"):
        unit.take_damage(owning_unit.golfer_resource.power)
