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

@export var face_mesh_instance: MeshInstance3D
@export var head_mesh_instance: MeshInstance3D
@export var body_mesh_instance: MeshInstance3D

@export var collar_mesh_instance: MeshInstance3D
@export var left_folded_pants_mesh_instance: MeshInstance3D
@export var right_folded_pants_mesh_instance: MeshInstance3D

@export_group("Gameplay")
@export var animation_tree: AnimationTree
@export var animation_player: AnimationPlayer
@export var right_hand_marker: Marker3D
@export var left_hand_marker: Marker3D


func call_primary_animation_event():
    primary_animation_event.emit()


func call_secondary_animation_event():
    secondary_animation_event.emit()
