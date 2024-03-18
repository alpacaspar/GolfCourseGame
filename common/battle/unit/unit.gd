class_name Unit
extends CharacterBody3D


const MOVEMENT_SPEED = 10.0

@export var player_controller: PackedScene
@export var ai_controller: PackedScene

var golfer_resource: GolferResource
var animation_tree: AnimationTree
var controller: Node

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")


func setup(new_golfer: GolferResource):
	golfer_resource = new_golfer
	
	if golfer_resource is PlayerRivalResource:
		controller = player_controller.instantiate()
	else:
		controller = ai_controller.instantiate()
	
	controller.body = self
	add_child(controller)
	
	var character := CharacterFactory.spawn_character(golfer_resource.npc_resource)
	$Visuals.add_child(character)

	animation_tree = character.animation_tree


func give_instructions(target_position: Vector3, _target_formation: Formation = null):
	# If the controller is a player controller, do nothing.
	# Technically the player will never receive instructions as they are not in a formation, but this is a good safety check.
	if controller.has_method("give_commands"):
		controller.give_commands(target_position, _target_formation)


func is_exhausted() -> bool:
	return golfer_resource.stamina <= 0
