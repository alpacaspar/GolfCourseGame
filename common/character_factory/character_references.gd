@tool
class_name CharacterReferences
extends Node3D


@export var ear_mesh: MeshInstance3D
@export var nose_mesh: MeshInstance3D
@export var hair_mesh: MeshInstance3D
@export var accessory_mesh: MeshInstance3D
@export var mouth_mesh: MeshInstance3D
@export var eye_mesh: MeshInstance3D
@export var eyebrow_mesh: MeshInstance3D

@export var preview_mesh: MeshInstance3D

var animation_tree: AnimationTree:
	get:
		if not animation_tree:
			animation_tree = $AnimationTree
		
		return animation_tree


func set_preview_mode(preview_mode: bool):
	ear_mesh.visible = !preview_mode
	nose_mesh.visible = !preview_mode
	hair_mesh.visible = !preview_mode
	#accessory_mesh.visible = !preview_mode
	mouth_mesh.visible = !preview_mode
	eye_mesh.visible = !preview_mode
	eyebrow_mesh.visible = !preview_mode

	preview_mesh.visible = preview_mode
