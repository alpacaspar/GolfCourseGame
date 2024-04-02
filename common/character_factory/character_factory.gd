@tool
extends Node


@export var ear_meshes: Array[Mesh] = []
@export var hair_meshes: Array[Mesh] = []
@export var nose_meshes: Array[Mesh] = []

@export var accessory_meshes: Array[Mesh] = []

@export var eye_textures: CompressedTexture2DArray
@export var eyebrow_textures: CompressedTexture2DArray
@export var mouth_textures: CompressedTexture2DArray

@export var character_base: PackedScene


func spawn_character(resource: NPCResource) -> CharacterReferences:
	var character = character_base.instantiate() as CharacterReferences

	character.eye_mesh.get_mesh().surface_get_material(0).set("albedo_texture", ImageTexture.create_from_image(eye_textures.get_layer_data(resource.eye_index)))
	character.mouth_mesh.get_mesh().surface_get_material(0).set("albedo_texture", ImageTexture.create_from_image(mouth_textures.get_layer_data(resource.mouth_index)))
	character.eyebrow_mesh.get_mesh().surface_get_material(0).set("albedo_texture", ImageTexture.create_from_image(eyebrow_textures.get_layer_data(resource.eyebrow_index)))

	character.ear_mesh.mesh = ear_meshes[resource.ear_index]
	character.nose_mesh.mesh = nose_meshes[resource.nose_index]
	character.hair_mesh.mesh = hair_meshes[resource.hair_index]

	character.hair_mesh.get_surface_override_material(0).set("albedo_color", resource.hair_color)
	character.ear_mesh.get_surface_override_material(0).set("albedo_color", resource.skin_color)
	character.nose_mesh.get_surface_override_material(0).set("albedo_color", resource.skin_color)
	
	return character
