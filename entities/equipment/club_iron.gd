extends Area3D


var owning_unit: Unit


func start_event():
	monitoring = true


func end_event():
	monitoring = false


func _on_body_entered(body: Node3D):
	if body == owning_unit:
		return
	
	if body.is_in_group("unit"):
		body.try_take_damage(owning_unit, owning_unit.team, owning_unit.golfer_resource.power)


func _on_area_entered(area: Area3D):
	if area.is_in_group("ball"):
		area.hit(owning_unit)
