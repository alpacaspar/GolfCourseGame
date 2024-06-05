@tool
extends Node


@export_group("Face Data")
@export_subgroup("Face Textures")
@export var eye_textures: CompressedTexture2DArray
@export var eyebrow_textures: CompressedTexture2DArray
@export var mouth_textures: CompressedTexture2DArray
@export var glasses_textures: CompressedTexture2DArray
@export var mustache_textures: CompressedTexture2DArray

@export var blush_textures: Array[Texture]
@export var beard_textures: Array[BeardDataHolder]
@export var eyeshadow_textures: Array[CompressedTexture2DArray]
@export var eyeliner_textures: Array[CompressedTexture2DArray]
@export var eyebrow_piercing_textures: Array[CompressedTexture2DArray]

@export_subgroup("Face Meshes")
@export var ear_meshes: Array[Mesh] = []
@export var hair_meshes: Array[Mesh] = []
@export var nose_meshes: Array[Mesh] = []

@export var earring_meshes: Array[EarringDataHolder] = []
@export var nose_piercing_datas: Array[NosePiercingDataHolder] = []

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

@export_group("Extra")
@export var character_base: PackedScene


# TODO: Make character will all things
func spawn_character(resource: NPCResource) -> Character:
	var character := character_base.instantiate() as Character
	var face_material: Material = character.face_mesh_instance.material_override
	var head_material: Material = character.head_mesh_instance.material_override
	var body_material: Material = character.body_mesh_instance.material_override
	var clothing_material: ShaderMaterial = character.body_mesh_instance.material_overlay

	# Face details
	face_material.set("shader_parameter/EyeIndex", resource.eye_index)
	face_material.set("shader_parameter/MouthIndex", resource.mouth_index)
	face_material.set("shader_parameter/EyebrowIndex", resource.eyebrow_index)

	var mustache_index = resource.mustache_index if resource.mustache_index >= 0 else mustache_textures.get_layers() - 1
	face_material.set("shader_parameter/MoustacheIndex", mustache_index)
	var glasses_index = resource.glasses_index if resource.glasses_index >= 0 else glasses_textures.get_layers() - 1
	face_material.set("shader_parameter/GlassesIndex", glasses_index )

	face_material.set("shader_parameter/EyeShadow", eyeshadow_textures[resource.eyeshadow_index])
	face_material.set("shader_parameter/Eyeliner", eyeliner_textures[resource.eyeliner_index])

	face_material.set("shader_parameter/EyebrowPiercings", eyebrow_piercing_textures[resource.eyebrow_piercing_index])

	# Face Colors
	face_material.set("shader_parameter/EyebrowColor", hair_colors[resource.eyebrow_color_index])
	face_material.set("shader_parameter/EyeShadowColor", eyeshadow_colors[resource.eyeshadow_color_index])
	face_material.set("shader_parameter/EyelinerColor", eyeliner_colors[resource.eyeliner_color_index])
	face_material.set("shader_parameter/LipColor", lip_colors[resource.lip_color_index])
	face_material.set("shader_parameter/MoustacheColor", hair_colors[resource.mustache_color_index])
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

	face_material.set("shader_parameter/GlassesPosition", Vector2(0, resource.glasses_values.vertical))
	# face_material.set("shader_parameter/GlassesSize", resource.glasses_values.scale)
  
	# Head Stuff
	head_material.set("shader_parameter/SkinColor", skin_colors[resource.skin_color_index])

	var beard_data = BeardDataHolder.new() if resource.beard_index < 0 else beard_textures[resource.beard_index]
	head_material.set("shader_parameter/Beards", beard_data.albedo)
	head_material.set("shader_parameter/BeardRoughness", beard_data.roughness)
	head_material.set("shader_parameter/BeardColor", hair_colors[resource.beard_color_index])

	var blush_data = null if resource.blush_index < 0 else blush_textures[resource.blush_index]
	head_material.set("shader_parameter/Blush", blush_data)
	head_material.set("shader_parameter/BlushColor", blush_colors[resource.blush_color_index])

	# Shirt stuff
	var shirt := shirt_datas[resource.shirt_index]
	character.collar_mesh_instance.mesh = shirt.collar
	if shirt.can_pick_color:
		clothing_material.set("shader_parameter/ShirtTint", shirt_colors[resource.shirt_color_index])
	else:
		clothing_material.set("shader_parameter/ShirtTint", Color.WHITE)

	clothing_material.set("shader_parameter/ShirtAlbedo", shirt.albedo)
	clothing_material.set("shader_parameter/ShirtRoughness", shirt.roughness)
	clothing_material.set("shader_parameter/ShirtNormal", shirt.normal)

	# Pants stuff
	var pants := pants_datas[resource.pants_index]
	if !pants.is_skirt:
		character.skirt_mesh_instance.visible = false
		if pants.can_pick_color:
			clothing_material.set("shader_parameter/PantsTint", pants_colors[resource.pants_color_index])
		else:
			clothing_material.set("shader_parameter/PantsTint", Color.WHITE)
		
		clothing_material.set("shader_parameter/PantsAlbedo", pants.albedo)
		clothing_material.set("shader_parameter/PantsRoughness", pants.roughness)
		clothing_material.set("shader_parameter/PantsNormal", pants.normal)
		if pants.show_cuffs:
			character.left_folded_pants_mesh_instance.visible = true
			character.right_folded_pants_mesh_instance.visible = true
		else:
			character.left_folded_pants_mesh_instance.visible = false
			character.right_folded_pants_mesh_instance.visible = false
	else:
		character.skirt_mesh_instance.visible = true
		clothing_material.set("shader_parameter/PantsAlbedo", null)
		clothing_material.set("shader_parameter/PantsRoughness", null)
		clothing_material.set("shader_parameter/PantsNormal", null)
		character.skirt_mesh_instance.material_override.albedo_color = pants_colors[resource.pants_color_index]

	# Shoes stuff
	var shoes := shoes_datas[resource.shoe_index]
	clothing_material.set("shader_parameter/ShoesTint", shirt_colors[resource.shoes_color_index])
	clothing_material.set("shader_parameter/ShoesAlbedo", shoes.albedo)
	clothing_material.set("shader_parameter/ShoesRoughness", shoes.roughness)
	clothing_material.set("shader_parameter/ShoesNormal", shoes.normal)
	clothing_material.set("shader_parameter/ShoesMetallic", shoes.metallic)
	clothing_material.set("shader_parameter/ShoesColorMask", shoes.color_mask)

	# Sock stuff
	var socks := sock_datas[resource.sock_index]
	if socks.can_pick_color:
		clothing_material.set("shader_parameter/SocksTint", shirt_colors[resource.sock_color_index])
	else:
		clothing_material.set("shader_parameter/SocksTint", Color.WHITE)
	clothing_material.set("shader_parameter/SocksAlbedo", socks.albedo)
	clothing_material.set("shader_parameter/SocksRoughness", socks.roughness)

	# Setting Wrist meshes
	if resource.wrist_index > -1:
		var wrist_data := wrists_datas[resource.wrist_index]
		character.wrist_mesh_instance.visible = true
		character.wrist_mesh_instance.mesh = wrist_data.mesh
		character.wrist_mesh_instance.material_override = wrist_data.material
	else:
		character.wrist_mesh_instance.visible = false

	# Setting Belt meshes
	if resource.belt_index > -1:
		var belt_data := belt_datas[resource.belt_index]
		character.belt_mesh_instance.visible = true
		character.belt_mesh_instance.material_override = belt_data.material
	else:
		character.belt_mesh_instance.visible = false
	
	# Setting Head meshes
	character.ear_mesh_instance.mesh = ear_meshes[resource.ear_index]
	if resource.earring_index == -1:
		character.ear_mesh_instance.material_overlay = null
		character.earring_mesh_instance.visible = false
	elif resource.earring_index < 3:
		character.ear_mesh_instance.material_overlay = null
		character.earring_mesh_instance.visible = true
		character.earring_mesh_instance.mesh = earring_meshes[resource.earring_index].meshes[resource.ear_index]
	else:
		character.earring_mesh_instance.visible = false
		character.ear_mesh_instance.material_overlay = earring_meshes[resource.earring_index].material

	character.nose_mesh_instance.mesh = nose_meshes[resource.nose_index]
	if resource.nose_piercing_index >= 0:
		character.nose_mesh_instance.material_overlay = nose_piercing_datas[resource.nose_piercing_index].material
	else:
		character.nose_mesh_instance.material_overlay = null
	
	var hair_mesh = hair_meshes[resource.hair_index] if resource.hair_index >= 0 else null
	character.hair_mesh_instance.mesh = hair_mesh

	# Setting Skin & Hair colors // Currently doesnt work
	body_material.set("albedo_color", skin_colors[resource.skin_color_index])
	character.hair_mesh_instance.material_override.set("albedo_color", hair_colors[resource.hair_color_index])
	character.ear_mesh_instance.material_override.set("albedo_color", skin_colors[resource.skin_color_index])
	character.nose_mesh_instance.material_override.set("albedo_color", skin_colors[resource.skin_color_index])

	return character
