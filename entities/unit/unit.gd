class_name Unit
extends CharacterBody3D


const MOVEMENT_SPEED = 10.0

var golfer_resource: GolferResource

var controller: Node3D

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

func setup(new_golfer: GolferResource, spawn_position: Vector3):
	golfer_resource = new_golfer
	transform.origin = spawn_position

	# Controller node will be added during the instantiation of this scene.
	controller = $Controller
	controller.body = self


func is_exhausted() -> bool:
	return golfer_resource.stamina <= 0
