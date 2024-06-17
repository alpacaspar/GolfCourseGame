@tool
class_name PreviewSpawner
extends Node


@export var preview_viewport: SubViewport
@export var preview_cam: Camera3D
@export var icon_viewport: SubViewport
@export var icon_cam: Camera3D

@export var zoom_holder_face: Node3D
@export var zoom_holder_body: Node3D
@export var unzoom_holder: Node3D

@export var character_spawn_position: Marker3D

var current_character: Character
var callback: Callable

var rotation_value: int = 180

var getting_icons: bool
var zoom_target: Vector3
var zoom_value: float


func _exit_tree():
	if current_character:
		current_character.queue_free()


func show_character(character: Character):
	preview_cam.make_current()

	add_child(character)

	current_character = character
	current_character.transform.origin = character_spawn_position.position

	zoom_target = zoom_holder_face.position


func on_process(_delta):	
	if !getting_icons:
		current_character.basis = Basis()
		current_character.rotate(Vector3.UP, deg_to_rad(180 + rotation_value))

	var img = preview_viewport.get_texture() as Texture2D
	callback.call(img)


func _set_rotation(value: float):
	rotation_value = value


func set_zoom(value := 0.0):
	zoom_value = value
	preview_cam.position = zoom_target.lerp(unzoom_holder.position, zoom_value)


func set_zoom_target(value := 0.0):
	zoom_target = zoom_holder_face.position.lerp(zoom_holder_body.position, value)
	preview_cam.position = zoom_target.lerp(unzoom_holder.position, zoom_value)


func create_icon(character_resource: NPCResource) -> Texture2D:
	set_zoom(1)
	
	icon_cam.current = true
	
	await RenderingServer.frame_post_draw
	icon_viewport.render_target_update_mode = SubViewport.UPDATE_ONCE
	await RenderingServer.frame_post_draw
	
	var image := icon_viewport.get_texture().get_image()
	
	preview_cam.current = true
	return ImageTexture.create_from_image(image)
