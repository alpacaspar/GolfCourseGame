class_name Unit
extends CharacterBody3D


const MOVEMENT_SPEED = 6.0

signal on_swing_performed

@onready var visuals: Node = $Visuals

var team: Team

var golfer_resource: GolferResource
var role: Role:
	get:
		return golfer_resource.role

var animation_tree: AnimationTree
var controller: Node
var equipment: Area3D

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

## The amount of units that are targetting this unit.
var targeting_units: Array[Unit] = []


func _on_swing_started():
	equipment.monitoring = true


func _on_swing_ended():
	equipment.monitoring = false


func setup(new_golfer: GolferResource, assigned_team: Team):
	golfer_resource = new_golfer
	team = assigned_team

	controller.unit = self

	var character: CharacterReferences = CharacterFactory.spawn_character(golfer_resource.npc_resource)
	visuals.add_child(character)

	# TODO: Figure out how to do this without hardcoding.
	equipment = character.right_hand_holder.get_child(0)
	equipment.parent_unit = self

	character.on_swing_started.connect(_on_swing_started)
	character.on_swing_ended.connect(_on_swing_ended)

	animation_tree = character.animation_tree


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


func start_targeting(targeting: Unit):
	targeting_units.append(targeting)


func stop_targeting(targeting: Unit):
	targeting_units.erase(targeting)


func get_target_amount() -> int:
	return targeting_units.size()
