class_name DetectionArea3D
extends Area3D
## Helper node for detecting entities in a 3D area.

@onready var area_shape: CollisionShape3D = $CollisionShape3D

## Get [Array] of [Vector3] positions of all characters that are overlapping with this area.
var overlapping_body_positions: Array[Vector3]:
	get:
		var result: Array[Vector3] = []

		for body in get_overlapping_bodies():
			result.append(body.global_position)

		return result


## Set the detection radius of this area.
## If the area shape is not a SphereShape3D, it will be converted to one.
func set_detection_radius(radius: float, padding := 0.0):
	if not area_shape.shape is SphereShape3D:
		area_shape.shape = SphereShape3D.new()
	
	area_shape.shape.radius = radius + padding