@tool
extends Node


@onready var face_viewport: SubViewport = $FaceViewport
@onready var clothing_edit_albedo_viewport: SubViewport = $ClothingAlbedoViewport
@onready var clothing_edit_normal_viewport: SubViewport = $ClothingNormalViewport
@onready var clothing_edit_roughness_viewport: SubViewport = $ClothingRoughnessViewport
@onready var clothing_edit_metallic_viewport: SubViewport = $ClothingMetallicViewport

var face_edit_material: Material:
	get:
		return face_viewport.get_child(0).material

var clothing_edit_albedo_material: Material:
	get:
		return clothing_edit_albedo_viewport.get_child(0).material

var clothing_edit_normal_material: Material:
	get:
		return clothing_edit_normal_viewport.get_child(0).material

var clothing_edit_metallic_material: Material:
	get:
		return clothing_edit_metallic_viewport.get_child(0).material

var clothing_edit_roughness_material: Material:
	get:
		return clothing_edit_roughness_viewport.get_child(0).material


func get_raw_face_texture() -> Texture:
	return face_viewport.get_texture()


func get_raw_clothing_albedo_texture() -> Texture:
	return clothing_edit_albedo_viewport.get_texture()


func get_raw_clothing_normal_texture() -> Texture:
	return clothing_edit_normal_viewport.get_texture()


func get_raw_clothing_roughness_texture() -> Texture:
	return clothing_edit_roughness_viewport.get_texture()


func get_raw_clothing_metallic_texture() -> Texture:
	return clothing_edit_metallic_viewport.get_texture()


func create_face_texture() -> Texture2D:
	return await _create_texture_from_viewport(face_viewport)


func create_clothing_albedo_texture() -> Texture2D:
	return await _create_texture_from_viewport(clothing_edit_albedo_viewport)


func create_clothing_normal_texture() -> Texture2D:
	return await _create_texture_from_viewport(clothing_edit_normal_viewport)

func create_clothing_roughness_texture() -> Texture2D:
	return await _create_texture_from_viewport(clothing_edit_roughness_viewport)


func create_clothing_metallic_texture() -> Texture2D:
	return await _create_texture_from_viewport(clothing_edit_metallic_viewport)


func _create_texture_from_viewport(viewport: Viewport) -> Texture2D:
	viewport.render_target_update_mode = SubViewport.UPDATE_ONCE
	await RenderingServer.frame_post_draw
	var image := viewport.get_texture().get_image()
	
	return ImageTexture.create_from_image(image)
