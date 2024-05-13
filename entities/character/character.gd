@tool
class_name Character
extends Node3D


signal animation_event_started
signal animation_event_ended


@export_group("Appearance")
@export var ear_mesh_instance: MeshInstance3D
@export var nose_mesh_instance: MeshInstance3D
@export var hair_mesh_instance: MeshInstance3D

@export var face_mesh_instance: MeshInstance3D
@export var body_mesh_instance: MeshInstance3D

@export var collar_mesh_instance: MeshInstance3D

@export var preview_mesh: MeshInstance3D

@export_group("Gameplay")
@export var animation_tree: AnimationTree
@export var primary_equipment_slot: Marker3D


func set_preview_mode(preview_mode: bool):
    ear_mesh_instance.visible = !preview_mode
    nose_mesh_instance.visible = !preview_mode
    hair_mesh_instance.visible = !preview_mode
    face_mesh_instance.visible = !preview_mode

    preview_mesh.visible = preview_mode


func start_animation_event():
    animation_event_started.emit()


func end_animation_event():
    animation_event_ended.emit()