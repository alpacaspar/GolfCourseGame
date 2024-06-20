@tool
class_name Character
extends Node3D


signal primary_animation_event
signal secondary_animation_event


@export_group("Appearance")
@export var ear_mesh_instance: MeshInstance3D
@export var earring_mesh_instance: MeshInstance3D
@export var nose_mesh_instance: MeshInstance3D
@export var hair_mesh_instance: MeshInstance3D
@export var wrist_mesh_instance: MeshInstance3D
@export var belt_mesh_instance: MeshInstance3D
@export var skirt_mesh_instance: MeshInstance3D

@export var face_mesh_instance: MeshInstance3D

@export var collar_mesh_instance: MeshInstance3D
@export var left_folded_pants_mesh_instance: MeshInstance3D
@export var right_folded_pants_mesh_instance: MeshInstance3D

@export_subgroup("Body")
@export var body_mesh_instance: MeshInstance3D
@export var head_mesh_instance: MeshInstance3D

@export var left_upper_leg_mesh_instance: MeshInstance3D
@export var left_bottom_leg_mesh_instance: MeshInstance3D
@export var left_foot_mesh_instance: MeshInstance3D
@export var left_upper_arm_mesh_instance: MeshInstance3D
@export var left_lower_arm_mesh_instance: MeshInstance3D
@export var left_hand_mesh_instance: MeshInstance3D

@export var right_upper_leg_mesh_instance: MeshInstance3D
@export var right_bottom_leg_mesh_instance: MeshInstance3D
@export var right_foot_mesh_instance: MeshInstance3D
@export var right_upper_arm_mesh_instance: MeshInstance3D
@export var right_lower_arm_mesh_instance: MeshInstance3D
@export var right_hand_mesh_instance: MeshInstance3D


@export_group("Gameplay")
@export var animation_tree: AnimationTree
@export var animation_player: AnimationPlayer
@export var right_hand_marker: Marker3D
@export var left_hand_marker: Marker3D

var npc: NPCResource:
	set = set_npc


func _ready():
	animation_tree.set("parameters/IdleSeek/seek_request", randf())


func set_npc(value: NPCResource):
	npc = value


func call_primary_animation_event():
	primary_animation_event.emit()


func call_secondary_animation_event():
	secondary_animation_event.emit()


func set_clothing_material(new_material: Material):
	body_mesh_instance.material_overlay = new_material

	left_upper_arm_mesh_instance.material_overlay = new_material
	left_lower_arm_mesh_instance.material_overlay = new_material
	left_hand_mesh_instance.material_overlay = new_material
	left_upper_leg_mesh_instance.material_overlay = new_material
	left_bottom_leg_mesh_instance.material_overlay = new_material
	left_foot_mesh_instance.material_overlay = new_material

	right_upper_arm_mesh_instance.material_overlay = new_material
	right_lower_arm_mesh_instance.material_overlay = new_material
	right_hand_mesh_instance.material_overlay = new_material
	right_upper_leg_mesh_instance.material_overlay = new_material
	right_bottom_leg_mesh_instance.material_overlay = new_material
	right_foot_mesh_instance.material_overlay = new_material

	left_folded_pants_mesh_instance.material_override = new_material
	right_folded_pants_mesh_instance.material_override = new_material

	collar_mesh_instance.material_override = new_material
