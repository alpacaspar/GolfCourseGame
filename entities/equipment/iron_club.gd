extends Area3D


var parent_unit: Unit


func _on_body_entered(body: Node3D):
	if body == parent_unit:
		return

	if not body is Unit:
		return

	if body.team == parent_unit.team:
		return

	if body.has_method("take_damage"):
		body.take_damage(parent_unit.golfer_resource.power)
