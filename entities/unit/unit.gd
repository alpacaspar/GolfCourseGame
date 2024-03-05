class_name Unit
extends CharacterBody3D


const MOVEMENT_SPEED = 10.0

var golfer_resource: GolferResource
var leader_resource: RivalResource

var controller: Node3D

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")


func _enter_tree():
    # Controller node will be added during the instantiation of this scene.
    controller = $Controller
    controller.body = self


func setup(new_golfer: GolferResource, new_leader: RivalResource):
    golfer_resource = new_golfer
    leader_resource = new_leader


func is_exhausted() -> bool:
    return golfer_resource.stamina <= 0
