@tool
class_name CharacterFactory
extends Node


@export var ear_meshes: Array[Mesh] = []
@export var hair_meshes: Array[Mesh] = []
@export var nose_meshes: Array[Mesh] = []

@export var character_base: PackedScene


func spawn_character(resource: NPCResource) -> Node3D:
	var character = character_base.instantiate()

	character.ear_mesh.mesh = ear_meshes[resource.ear_index]
	character.nose_mesh.mesh = nose_meshes[resource.nose_index]
	character.hair_mesh.mesh = hair_meshes[resource.hair_index]
	
	return character
