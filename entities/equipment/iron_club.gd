extends Area3D


var owning_unit: Unit


func start_event():
    monitoring = true


func end_event():
    monitoring = false


func _on_body_entered(unit: Node3D):
    if unit == owning_unit:
        return

    if not unit is Unit:
        return

    if unit.team == owning_unit.team:
        return

    if unit.has_method("take_damage"):
        unit.take_damage(owning_unit.golfer_resource.power)
