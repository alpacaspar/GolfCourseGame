@tool
class_name Character
extends Node3D


signal on_swing_started
signal on_swing_ended

@export var ear_mesh_instance: MeshInstance3D
@export var nose_mesh_instance: MeshInstance3D
@export var hair_mesh_instance: MeshInstance3D
#@export var accessory_mesh_instance: MeshInstance3D

@export var face_mesh_instance: MeshInstance3D

# TODO: Add some reference to material overrides for body / clothes.
@export var collar_mesh_instance: MeshInstance3D

@export var preview_mesh: MeshInstance3D

@export var animation_tree: AnimationTree
@export var right_hand_holder: Marker3D


func set_preview_mode(preview_mode: bool):
	ear_mesh_instance.visible = !preview_mode
	nose_mesh_instance.visible = !preview_mode
	hair_mesh_instance.visible = !preview_mode
	face_mesh_instance.visible = !preview_mode
	
	preview_mesh.visible = preview_mode


func start_swing():
	on_swing_started.emit()


func end_swing():
	on_swing_ended.emit()
