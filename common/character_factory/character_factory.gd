@tool
extends Node


@export var ear_meshes: Array[Mesh] = []
@export var hair_meshes: Array[Mesh] = []
@export var nose_meshes: Array[Mesh] = []

@export var accessory_meshes: Array[Mesh] = []
@export var eye_meshes: Array[Mesh] = []
@export var mouth_meshes: Array[Mesh] = []

@export var character_base: PackedScene


func spawn_character(resource: NPCResource) -> CharacterReferences:
	var character = character_base.instantiate() as CharacterReferences

	character.ear_mesh.mesh = ear_meshes[resource.ear_index]
	character.nose_mesh.mesh = nose_meshes[resource.nose_index]
	character.hair_mesh.mesh = hair_meshes[resource.hair_index]
	
	return character
