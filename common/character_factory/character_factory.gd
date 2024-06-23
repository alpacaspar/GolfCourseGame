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
@export var empty_map: CompressedTexture2DArray

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
@export var eye_blink_index := 14

@export var face_edit_material: Material
@export var face_default_material: Material
@export var clothing_edit_material: Material
@export var clothing_default_material: Material
@export var character_texture_renderer_scene: PackedScene

var active_texture_renderers: Dictionary = {}


func create_character(resource: NPCResource) -> Character:
	var character := character_base.instantiate() as Character
	character.set_npc(resource)

	if not active_texture_renderers.has(character):
		var instance: Node = character_texture_renderer_scene.instantiate()
		add_child(instance)
		active_texture_renderers[character] = instance

	return character


func start_character_creation(character: Character):
	refresh_character(character)

	character.face_mesh_instance.material_override = face_edit_material.duplicate()
	character.face_mesh_instance.material_override.albedo_texture = active_texture_renderers[character].get_raw_face_texture()

	var clothing_material: Material = clothing_edit_material.duplicate()
	clothing_material.albedo_texture = active_texture_renderers[character].get_raw_clothing_albedo_texture()
	clothing_material.roughness_texture = active_texture_renderers[character].get_raw_clothing_roughness_texture()
	clothing_material.normal_texture = active_texture_renderers[character].get_raw_clothing_normal_texture()
	clothing_material.metallic_texture = active_texture_renderers[character].get_raw_clothing_metallic_texture()

	character.set_clothing_material(clothing_material)


## End the character creation process and apply the face texture to the character.
## Use [code]await[/code] if the character is destroyed after this function.
func end_character_creation(character: Character):
	character.face_mesh_instance.material_override = face_default_material.duplicate()

	var face_texture:Texture2D = await active_texture_renderers[character].create_face_texture()
	var face_blink_texture := await _create_face_blink_texture(active_texture_renderers[character])

	character.face_mesh_instance.material_override.set("shader_parameter/face", face_texture)
	character.face_mesh_instance.material_override.set("shader_parameter/face_blink", face_blink_texture)
	character.face_mesh_instance.material_override.set("shader_parameter/blink_offset", randf())

	var clothing_albedo_texture:Texture2D = await active_texture_renderers[character].create_clothing_albedo_texture()
	var clothing_normal_texture:Texture2D = await active_texture_renderers[character].create_clothing_normal_texture()
	var clothing_roughness_texture:Texture2D = await active_texture_renderers[character].create_clothing_roughness_texture()
	var clothing_metallic_texture:Texture2D = await active_texture_renderers[character].create_clothing_metallic_texture()

	var clothing_material: Material = clothing_default_material.duplicate()

	clothing_material.albedo_texture = clothing_albedo_texture
	clothing_material.normal_texture = clothing_normal_texture
	clothing_material.roughness_texture = clothing_roughness_texture
	clothing_material.metallic_texture = clothing_metallic_texture

	character.set_clothing_material(clothing_material)

	active_texture_renderers[character].queue_free()
	active_texture_renderers.erase(character)

	for instance: Node in active_texture_renderers.keys():
		if not instance or not is_instance_valid(instance):
			active_texture_renderers[instance].queue_free()
			active_texture_renderers.erase(instance)


func refresh_character(character: Character):
	var resource: NPCResource = character.npc

	var texture_renderer: Node = active_texture_renderers[character]

	var face_renderer_material: Material = texture_renderer.face_edit_material
	var head_material: Material = character.head_mesh_instance.material_override

	# Face details
	face_renderer_material.set("shader_parameter/EyeIndex", resource.eye_index)
	face_renderer_material.set("shader_parameter/MouthIndex", resource.mouth_index)
	face_renderer_material.set("shader_parameter/EyebrowIndex", resource.eyebrow_index)

	var mustache_index := resource.mustache_index if resource.mustache_index >= 0 else mustache_textures.get_layers() - 1
	face_renderer_material.set("shader_parameter/MoustacheIndex", mustache_index)
	var glasses_index := resource.glasses_index if resource.glasses_index >= 0 else glasses_textures.get_layers() - 1
	face_renderer_material.set("shader_parameter/GlassesIndex", glasses_index )

	var eyeshadow := eyeshadow_textures[resource.eyeshadow_index] if resource.eyeshadow_index > -1 else empty_map
	face_renderer_material.set("shader_parameter/EyeShadow", eyeshadow)
	var eyeliner := eyeliner_textures[resource.eyeliner_index] if resource.eyeliner_index > -1 else empty_map
	face_renderer_material.set("shader_parameter/Eyeliner", eyeliner)
	var eyebrow_piercing := eyebrow_piercing_textures[resource.eyebrow_piercing_index] if resource.eyebrow_piercing_index > -1 else empty_map
	face_renderer_material.set("shader_parameter/EyebrowPiercings", eyebrow_piercing)

	# Face Colors
	face_renderer_material.set("shader_parameter/EyebrowColor", hair_colors[resource.eyebrow_color_index])
	face_renderer_material.set("shader_parameter/EyeShadowColor", eyeshadow_colors[resource.eyeshadow_color_index])
	face_renderer_material.set("shader_parameter/EyelinerColor", eyeliner_colors[resource.eyeliner_color_index])
	face_renderer_material.set("shader_parameter/LipColor", lip_colors[resource.lip_color_index])
	face_renderer_material.set("shader_parameter/MoustacheColor", hair_colors[resource.mustache_color_index])
	#face_material.set("shader_parameter/GlassesColor", glasses_colors[resource.glasses_color_index])

	# Face Offsets
	face_renderer_material.set("shader_parameter/EyePosition", Vector2(resource.eye_values.horizontal, resource.eye_values.vertical))
	face_renderer_material.set("shader_parameter/EyeSize", resource.eye_values.scale)
	face_renderer_material.set("shader_parameter/EyeAngle", resource.eye_values.rotation)
	
	face_renderer_material.set("shader_parameter/EyebrowPosition", Vector2(resource.eyebrow_values.horizontal, resource.eyebrow_values.vertical))
	face_renderer_material.set("shader_parameter/EyebrowSize", resource.eyebrow_values.scale)
	face_renderer_material.set("shader_parameter/EyebrowAngle", resource.eyebrow_values.rotation)

	face_renderer_material.set("shader_parameter/MouthPosition", resource.mouth_values.vertical)
	face_renderer_material.set("shader_parameter/MouthSize", resource.mouth_values.scale)

	face_renderer_material.set("shader_parameter/MoustachePosition", resource.mustache_values.vertical)
	face_renderer_material.set("shader_parameter/MoustacheSize", resource.mustache_values.scale)

	face_renderer_material.set("shader_parameter/GlassesPosition", Vector2(0, resource.glasses_values.vertical))
	# face_material.set("shader_parameter/GlassesSize", resource.glasses_values.scale)
  
	# Head Stuff
	head_material.set("shader_parameter/SkinColor", skin_colors[resource.skin_color_index])

	var beard_data := BeardDataHolder.new() if resource.beard_index < 0 else beard_textures[resource.beard_index]
	head_material.set("shader_parameter/Beards", beard_data.albedo)
	head_material.set("shader_parameter/BeardRoughness", beard_data.roughness)
	head_material.set("shader_parameter/BeardColor", hair_colors[resource.beard_color_index])

	var blush_data := null if resource.blush_index < 0 else blush_textures[resource.blush_index]
	head_material.set("shader_parameter/Blush", blush_data)
	head_material.set("shader_parameter/BlushColor", blush_colors[resource.blush_color_index])

	var clothing_albedo_material: ShaderMaterial = texture_renderer.clothing_edit_albedo_material
	var clothing_normal_material: ShaderMaterial = texture_renderer.clothing_edit_normal_material
	var clothing_roughness_material: ShaderMaterial = texture_renderer.clothing_edit_roughness_material
	var clothing_metallic_material: ShaderMaterial = texture_renderer.clothing_edit_metallic_material

	# Shirt stuff
	var shirt := shirt_datas[resource.shirt_index]
	character.collar_mesh_instance.mesh = shirt.collar
	if shirt.can_pick_color:
		clothing_albedo_material.set("shader_parameter/ShirtTint", shirt_colors[resource.shirt_color_index])
	else:
		clothing_albedo_material.set("shader_parameter/ShirtTint", Color.WHITE)

	clothing_albedo_material.set("shader_parameter/ShirtAlbedo", shirt.albedo)
	clothing_roughness_material.set("shader_parameter/ShirtRoughness", shirt.roughness)
	clothing_normal_material.set("shader_parameter/ShirtNormal", shirt.normal)

	# Pants stuff
	var pants := pants_datas[resource.pants_index]
	if !pants.is_skirt:
		character.skirt_mesh_instance.visible = false
		if pants.can_pick_color:
			clothing_albedo_material.set("shader_parameter/PantsTint", pants_colors[resource.pants_color_index])
		else:
			clothing_albedo_material.set("shader_parameter/PantsTint", Color.WHITE)
		
		clothing_albedo_material.set("shader_parameter/PantsAlbedo", pants.albedo)
		clothing_roughness_material.set("shader_parameter/PantsRoughness", pants.roughness)
		clothing_normal_material.set("shader_parameter/PantsNormal", pants.normal)
		if pants.show_cuffs:
			character.left_folded_pants_mesh_instance.visible = true
			character.right_folded_pants_mesh_instance.visible = true
		else:
			character.left_folded_pants_mesh_instance.visible = false
			character.right_folded_pants_mesh_instance.visible = false
	else:
		character.skirt_mesh_instance.visible = true
		character.left_folded_pants_mesh_instance.visible = false
		character.right_folded_pants_mesh_instance.visible = false
		
		clothing_albedo_material.set("shader_parameter/PantsAlbedo", pants.albedo)
		clothing_roughness_material.set("shader_parameter/PantsRoughness", pants.roughness)
		clothing_normal_material.set("shader_parameter/PantsNormal", pants.normal)
		clothing_albedo_material.set("shader_parameter/PantsTint", Color.WHITE)

		character.skirt_mesh_instance.material_override.albedo_color = pants_colors[resource.pants_color_index]

	# Shoes stuff
	var shoes := shoes_datas[resource.shoe_index]
	clothing_albedo_material.set("shader_parameter/ShoesTint", shirt_colors[resource.shoes_color_index])
	clothing_albedo_material.set("shader_parameter/ShoesAlbedo", shoes.albedo)
	clothing_roughness_material.set("shader_parameter/ShoesRoughness", shoes.roughness)
	clothing_normal_material.set("shader_parameter/ShoesNormal", shoes.normal)
	clothing_metallic_material.set("shader_parameter/ShoesMetallic", shoes.metallic)
	clothing_albedo_material.set("shader_parameter/ShoesColorMask", shoes.color_mask)

	# Sock stuff
	var socks := sock_datas[resource.sock_index]
	if socks.can_pick_color:
		clothing_albedo_material.set("shader_parameter/SocksTint", shirt_colors[resource.sock_color_index])
	else:
		clothing_albedo_material.set("shader_parameter/SocksTint", Color.WHITE)
	clothing_albedo_material.set("shader_parameter/SocksAlbedo", socks.albedo)
	clothing_roughness_material.set("shader_parameter/SocksRoughness", socks.roughness)

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
	if resource.nose_piercing_index > -1:
		character.nose_mesh_instance.material_overlay = nose_piercing_datas[resource.nose_piercing_index].material
	else:
		character.nose_mesh_instance.material_overlay = null
	
	var hair_mesh := hair_meshes[resource.hair_index] if resource.hair_index >= 0 else null
	character.hair_mesh_instance.mesh = hair_mesh

	# Setting Skin & Hair colors
	character.hair_mesh_instance.material_override.set("albedo_color", hair_colors[resource.hair_color_index])
	character.ear_mesh_instance.material_override.set("albedo_color", skin_colors[resource.skin_color_index])
	character.nose_mesh_instance.material_override.set("albedo_color", skin_colors[resource.skin_color_index])


func _create_face_blink_texture(face_renderer: Node) -> Texture2D:
	face_renderer.face_edit_material.set("shader_parameter/EyeIndex", eye_blink_index)

	return await face_renderer.create_face_texture()
