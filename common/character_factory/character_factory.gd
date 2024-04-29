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
    var face_material: Material = character.face_mesh_instance.material_override

    face_material.set("shader_parameter/EyeIndex", resource.eye_index)
    face_material.set("shader_parameter/MouthIndex", resource.mouth_index)
    face_material.set("shader_parameter/EyebrowIndex", resource.eyebrow_index)
    
    face_material.set("shader_parameter/EyeHeight", remap(resource.eye_offset, 0, 1, -.5, .5))
    face_material.set("shader_parameter/EyebrowHeight", remap(resource.eyebrow_offset, 0, 1, -.6, .4))
    face_material.set("shader_parameter/MouthSize", remap(resource.mouth_size, 0, 1, 0, 2))
    face_material.set("shader_parameter/MouthHeight", remap(resource.mouth_offset, 0, 1, -.2, .8))

    character.ear_mesh_instance.mesh = ear_meshes[resource.ear_index]
    character.nose_mesh_instance.mesh = nose_meshes[resource.nose_index]
    character.hair_mesh_instance.mesh = hair_meshes[resource.hair_index]

    character.hair_mesh_instance.get_mesh().surface_get_material(0).set("albedo_color", resource.hair_color)
    character.ear_mesh_instance.get_mesh().surface_get_material(0).set("albedo_color", resource.skin_color)
    character.nose_mesh_instance.get_mesh().surface_get_material(0).set("albedo_color", resource.skin_color)
	
    return character
