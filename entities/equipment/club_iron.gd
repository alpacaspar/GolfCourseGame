extends Area3D


var owning_unit: Unit


func start_event():
	monitoring = true


func end_event():
	monitoring = false


func _on_body_entered(unit: Node3D):
	if not unit is Unit:
		return

	if unit.has_method("try_take_damage"):
		unit.try_take_damage(owning_unit, owning_unit.golfer_resource.power)
