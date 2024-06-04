@tool
extends Node


@export_group("Face Data")
@export_subgroup("Face Textures")
@export var eye_textures: CompressedTexture2DArray
@export var eyebrow_textures: CompressedTexture2DArray
@export var mouth_textures: CompressedTexture2DArray
@export var glasses_textures: CompressedTexture2DArray
@export var mustache_textures: CompressedTexture2DArray

@export var beard_textures: Array[Texture]
@export var blush_textures: Array[Texture]
@export var eyeshadow_textures: Array[CompressedTexture2DArray]
@export var eyeliner_textures: Array[CompressedTexture2DArray]
@export var eyebrow_piercing_textures: Array[CompressedTexture2DArray]

@export_subgroup("Face Meshes")
@export var ear_meshes: Array[Mesh] = []
@export var earring_meshes: Array[Mesh] = []
@export var hair_meshes: Array[Mesh] = []
@export var nose_meshes: Array[Mesh] = []

@export_subgroup("Face Colors")
@export var skin_colors: Array[Color] = []
@export var hair_colors: Array[Color] = []

@export var lip_colors: Array[Color] = []
@export var eyeshadow_colors: Array[Color] = []
@export var eyeliner_colors: Array[Color] = []
@export var blush_colors: Array[Color] = []

@export var glasses_colors: Array[Color] = []

@export_group("Clothing")
@export_subgroup("Clothing Datas")
@export var shirt_datas: Array[ShirtsClothingResource] = []
@export var pants_datas: Array[PantsClothingResource] = []
@export var sock_datas: Array[SocksClothingResource] = []
@export var shoes_datas: Array[ShoesClothingResource] = []
@export var belt_datas: Array[BeltAccessoryResource] = []
@export var wrists_datas: Array[WristAccessoryResource] = []

@export_subgroup("Clothing Colors")
@export var shirt_colors: Array[Color] = []
@export var pants_colors: Array[Color] = []
@export var belt_colors: Array[Color] = []

@export_group("Extra")
@export var character_base: PackedScene


# TODO: Make character will all things
func spawn_character(resource: NPCResource) -> Character:
	var character := character_base.instantiate() as Character
	var face_material: Material = character.face_mesh_instance.material_override
	var body_material: Material = character.body_mesh_instance.material_override
	var clothing_material: ShaderMaterial = character.body_mesh_instance.material_overlay

	# Face details
	face_material.set("shader_parameter/EyeIndex", resource.eye_index)
	face_material.set("shader_parameter/MouthIndex", resource.mouth_index)
	face_material.set("shader_parameter/EyebrowIndex", resource.eyebrow_index)
	face_material.set("shader_parameter/MoustacheIndex", resource.mustache_index)
	#face_material.set("shader_parameter/BeardIndex", resource.beard_index)

	face_material.set("shader_parameter/EyeShadow", eyeshadow_textures[resource.eyeshadow_index])
	face_material.set("shader_parameter/EyebrowPiercings", eyebrow_piercing_textures[resource.eyebrow_piercing_index])
	face_material.set("shader_parameter/Eyeliner", eyeliner_textures[resource.eyeliner_index])

	# Face Colors
	face_material.set("shader_parameter/EyebrowColor", hair_colors[resource.eyebrow_color_index])
	face_material.set("shader_parameter/EyeShadowColor", eyeshadow_colors[resource.eyeshadow_color_index])
	face_material.set("shader_parameter/EyelinerColor", eyeliner_colors[resource.eyeliner_color_index])
	face_material.set("shader_parameter/LipColor", lip_colors[resource.lip_color_index])
	face_material.set("shader_parameter/MoustacheColor", hair_colors[resource.mustache_color_index])
	#face_material.set("shader_parameter/BeardColor", hair_colors[resource.beard_color_index])
	#face_material.set("shader_parameter/GlassesColor", glasses_colors[resource.glasses_color_index])

	# Face Offsets
	face_material.set("shader_parameter/EyePosition", Vector2(resource.eye_values.horizontal, resource.eye_values.vertical))
	face_material.set("shader_parameter/EyeSize", resource.eye_values.scale)
	face_material.set("shader_parameter/EyeAngle", resource.eye_values.rotation)
	
	face_material.set("shader_parameter/EyebrowPosition", Vector2(resource.eyebrow_values.horizontal, resource.eyebrow_values.vertical))
	face_material.set("shader_parameter/EyebrowSize", resource.eyebrow_values.scale)
	face_material.set("shader_parameter/EyebrowAngle", resource.eyebrow_values.rotation)

	face_material.set("shader_parameter/MouthPosition", resource.mouth_values.vertical)
	face_material.set("shader_parameter/MouthSize", resource.mouth_values.scale)

	face_material.set("shader_parameter/MoustachePosition", resource.mustache_values.vertical)
	face_material.set("shader_parameter/MoustacheSize", resource.mustache_values.scale)

	#face_material.set("shader_parameter/GlassesPosition", resource.glasses_values.vertical)
	#face_material.set("shader_parameter/GlassesSize", resource.glasses_values.scale)
  
	# # Shirt stuff
	# var shirt := shirt_datas[resource.shirt_index]
	# character.collar_mesh_instance.mesh = shirt.collar_mesh
	# clothing_material.set("shader_parameter/ShirtTint", shirt_colors[resource.shirt_color_index])
	# clothing_material.set("shader_parameter/ShirtAlbedo", shirt.albedo)
	# clothing_material.set("shader_parameter/ShirtRoughness", shirt.roughness)
	# clothing_material.set("shader_parameter/ShirtNormal", shirt.normal)

	# # Pants stuff
	# var pants := pants_datas[resource.pants_index]
	# clothing_material.set("shader_parameter/PantsTint", pants_colors[resource.pants_color_index])
	# clothing_material.set("shader_parameter/PantsAlbedo", pants.albedo)
	# clothing_material.set("shader_parameter/PantsRoughness", pants.roughness)
	# clothing_material.set("shader_parameter/PantsNormal", pants.normal)

	# # Setting Head meshes
	# character.ear_mesh_instance.mesh = ear_meshes[resource.ear_index]
	# character.nose_mesh_instance.mesh = nose_meshes[resource.nose_index]
	# character.hair_mesh_instance.mesh = hair_meshes[resource.hair_index]

	# Setting Skin & Hair colors
	body_material.set("albedo_color", skin_colors[resource.skin_color_index])
	character.hair_mesh_instance.material_override.set("albedo_color", hair_colors[resource.hair_color_index])
	character.ear_mesh_instance.material_override.set("albedo_color", skin_colors[resource.skin_color_index])
	character.nose_mesh_instance.material_override.set("albedo_color", skin_colors[resource.skin_color_index])

	return character
