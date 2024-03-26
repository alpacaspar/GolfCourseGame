@tool
class_name CharacterReferences
extends Node3D


signal on_swing_started
signal on_swing_ended

@export var ear_mesh: MeshInstance3D
@export var nose_mesh: MeshInstance3D
@export var hair_mesh: MeshInstance3D
@export var accessory_mesh: MeshInstance3D

@export var mouth_mesh: MeshInstance3D
@export var eye_mesh: MeshInstance3D
@export var eyebrow_mesh: MeshInstance3D

@export var preview_mesh: MeshInstance3D

@export var animation_tree: AnimationTree
@export var right_hand_holder: Marker3D


func set_preview_mode(preview_mode: bool):
	ear_mesh.visible = !preview_mode
	nose_mesh.visible = !preview_mode
	hair_mesh.visible = !preview_mode
	
	mouth_mesh.visible = !preview_mode
	eye_mesh.visible = !preview_mode
	eyebrow_mesh.visible = !preview_mode
	
	# accessory_mesh.visible = !preview_mode

	preview_mesh.visible = preview_mode


func start_swing():
	on_swing_started.emit()


func end_swing():
	on_swing_ended.emit()
