@tool
extends Node


@export var ear_meshes: Array[Mesh] = []
@export var hair_meshes: Array[Mesh] = []
@export var nose_meshes: Array[Mesh] = []

@export var shirt_datas: Array[NPCClothingResource] = []
@export var pants_datas: Array[NPCClothingResource] = []

@export var eye_textures: CompressedTexture2DArray
@export var eyebrow_textures: CompressedTexture2DArray
@export var mouth_textures: CompressedTexture2DArray

@export var character_base: PackedScene


func spawn_character(resource: NPCResource) -> Character:
    var character = character_base.instantiate() as Character
    var face_material: Material = character.face_mesh_instance.material_override
    var body_material: Material = character.body_mesh_instance.material_override
    var clothing_material: ShaderMaterial = character.body_mesh_instance.material_overlay

    face_material.set("shader_parameter/EyeIndex", resource.eye_index)
    face_material.set("shader_parameter/MouthIndex", resource.mouth_index)
    face_material.set("shader_parameter/EyebrowIndex", resource.eyebrow_index)
    
    face_material.set("shader_parameter/EyeHeight", remap(resource.eye_offset, 0, 1, -.5, .5))
    face_material.set("shader_parameter/EyebrowHeight", remap(resource.eyebrow_offset, 0, 1, -.6, .4))
    face_material.set("shader_parameter/MouthSize", remap(resource.mouth_size, 0, 1, 0, 2))
    face_material.set("shader_parameter/MouthHeight", remap(resource.mouth_offset, 0, 1, -.2, .8))

    var shirt = shirt_datas[resource.shirt_index]
    character.collar_mesh_instance.mesh = shirt.collar_mesh
    clothing_material.set("shader_parameter/ShirtTint", resource.shirt_color)
    clothing_material.set("shader_parameter/ShirtAlbedo", shirt.albedo)
    clothing_material.set("shader_parameter/ShirtRoughness", shirt.roughness)
    clothing_material.set("shader_parameter/ShirtNormal", shirt.normal)

    var pants = pants_datas[resource.pants_index]
    clothing_material.set("shader_parameter/PantsTint", resource.pants_color)
    clothing_material.set("shader_parameter/PantsAlbedo", pants.albedo)
    clothing_material.set("shader_parameter/PantsRoughness", pants.roughness)
    clothing_material.set("shader_parameter/PantsNormal", pants.normal)

    character.ear_mesh_instance.mesh = ear_meshes[resource.ear_index]
    character.nose_mesh_instance.mesh = nose_meshes[resource.nose_index]
    character.hair_mesh_instance.mesh = hair_meshes[resource.hair_index]

    body_material.set("albedo_color", resource.skin_color)
    character.hair_mesh_instance.material_override.set("albedo_color", resource.hair_color)
    character.ear_mesh_instance.material_override.set("albedo_color", resource.skin_color)
    character.nose_mesh_instance.material_override.set("albedo_color", resource.skin_color)
	
    return character
