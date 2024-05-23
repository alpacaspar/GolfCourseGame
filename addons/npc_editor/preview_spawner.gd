@tool
class_name PreviewSpawner
extends Node


@export var preview_viewport: SubViewport
@export var preview_cam: Camera3D
@export var icon_viewport: SubViewport
@export var icon_cam: Camera3D

@export var zoom_holder: Node3D
@export var unzoom_holder: Node3D

@export var character_spawn_position: Marker3D

var spawned_character: Character
var callback: Callable

var rotation_value: int = 180
var zoom_value: int

var getting_icons: bool


func make_ready():
	preview_cam.make_current()

	_spawn_character(NPCResource.new())


func on_process(_delta):	
	if !getting_icons:
		spawned_character.basis = Basis()
		spawned_character.rotate(Vector3.UP, deg_to_rad(180 + rotation_value))

	var img = preview_viewport.get_texture() as Texture2D
	callback.call(img)


func create_button_icon(mesh, rotate: bool) -> Texture:
	spawned_character.preview_mesh.mesh = mesh

	getting_icons = true
	icon_cam.current = true

	spawned_character.basis = Basis()
	if rotate:
		spawned_character.rotate(Vector3.UP, deg_to_rad(90))
	else:
		spawned_character.rotate(Vector3.UP, deg_to_rad(0))

	icon_viewport.render_target_update_mode = 1
	await RenderingServer.frame_post_draw
	var image = icon_viewport.get_texture().get_image()

	# spawned_character.set_preview_mode(false)
	spawned_character.rotate(Vector3.UP, deg_to_rad(180 + rotation_value))
	
	preview_cam.current = true
	getting_icons = false
	return ImageTexture.create_from_image(image)


func _set_rotation(_value: float):
	rotation_value = _value


func _set_zoom(_value := 0.0):
	preview_cam.position = zoom_holder.position.lerp(unzoom_holder.position, 1 - _value)


func _spawn_character(character_resource: NPCResource):
	spawned_character = CharacterFactory.spawn_character(character_resource) as Character
	add_child(spawned_character)
	spawned_character.position = character_spawn_position.position


func _edit_character(_character_resource: NPCResource):
	spawned_character.queue_free()
	_spawn_character(_character_resource)


func _exit_tree():
	spawned_character.queue_free()


func create_icon(_character_resource: NPCResource) -> Texture2D:
	_edit_character(_character_resource)
	_set_zoom(1)
	
	icon_cam.current = true
	icon_viewport.render_target_update_mode = 1
	await RenderingServer.frame_post_draw
	var image = icon_viewport.get_texture().get_image()
	
	preview_cam.current = true
	return ImageTexture.create_from_image(image)
