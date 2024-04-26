@tool
extends Node


@export var ear_meshes: Array[Mesh] = []
@export var hair_meshes: Array[Mesh] = []
@export var nose_meshes: Array[Mesh] = []

@export var collar_meshes: Array[Mesh] = []

@export var eye_textures: CompressedTexture2DArray
@export var eyebrow_textures: CompressedTexture2DArray
@export var mouth_textures: CompressedTexture2DArray

@export var character_base: PackedScene


func spawn_character(resource: NPCResource) -> Character:
    var character = character_base.instantiate() as Character

    # character.eye_mesh.get_mesh().surface_get_material(0).set("albedo_texture", ImageTexture.create_from_image(eye_textures.get_layer_data(resource.eye_index)))
    # character.mouth_mesh.get_mesh().surface_get_material(0).set("albedo_texture", ImageTexture.create_from_image(mouth_textures.get_layer_data(resource.mouth_index)))
    # character.eyebrow_mesh.get_mesh().surface_get_material(0).set("albedo_texture", ImageTexture.create_from_image(eyebrow_textures.get_layer_data(resource.eyebrow_index)))

    var face_material: Material = character.face_mesh_instance.get_surface_override_material(0)
    face_material.set("eye_index", resource.eye_index)
    face_material.set("mouth_index", resource.mouth_index)
    face_material.set("eyebrow_index", resource.eyebrow_index)

    character.ear_mesh_instance.mesh = ear_meshes[resource.ear_index]
    character.nose_mesh_instance.mesh = nose_meshes[resource.nose_index]
    character.hair_mesh_instance.mesh = hair_meshes[resource.hair_index]

    character.hair_mesh_instance.get_surface_override_material(0).set("albedo_color", resource.hair_color)
    character.ear_mesh_instance.get_surface_override_material(0).set("albedo_color", resource.skin_color)
    character.nose_mesh_instance.get_surface_override_material(0).set("albedo_color", resource.skin_color)
    
    return character
