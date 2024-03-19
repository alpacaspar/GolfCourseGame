class_name Unit
extends CharacterBody3D


const MOVEMENT_SPEED = 6.0

signal on_swing_performed

@export var player_controller: PackedScene
@export var ai_controller: PackedScene

@onready var visuals: Node = $Visuals

var team: Team
var formation: Formation

var golfer_resource: GolferResource

var animation_tree: AnimationTree
var controller: Node
var equipment: Area3D

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")


func _on_swing_started():
	equipment.monitoring = true


func _on_swing_ended():
	equipment.monitoring = false


func setup(new_golfer: GolferResource, assigned_formation: Formation, assigned_team: Team):
	golfer_resource = new_golfer
	formation = assigned_formation
	team = assigned_team
	
	if golfer_resource is PlayerRivalResource:
		controller = player_controller.instantiate()
	else:
		controller = ai_controller.instantiate()
	
	controller.body = self
	add_child(controller)
	
	var character: CharacterReferences = CharacterFactory.spawn_character(golfer_resource.npc_resource)
	visuals.add_child(character)
	
	# TODO: Figure out how to do this without hardcoding.
	equipment = character.right_hand_holder.get_child(0)
	equipment.parent_unit = self

	character.on_swing_started.connect(_on_swing_started)
	character.on_swing_ended.connect(_on_swing_ended)

	animation_tree = character.animation_tree


func give_instructions(target_position: Vector3, _target_formation: Formation = null):
	# If the controller is a player controller, do nothing.
	# Technically the player will never receive instructions as they are not in a formation, but this is a good safety check.
	if controller.has_method("give_commands"):
		controller.give_commands(target_position, _target_formation)


func perform_swing():
	on_swing_performed.emit()


func is_exhausted() -> bool:
	return golfer_resource.stamina <= 0


func take_damage(damage: int):
	golfer_resource.stamina -= damage

	if golfer_resource.stamina <= 0:
		golfer_resource.stamina = 0
		_exhaust()


func _exhaust():
	queue_free()
