@tool
class_name PreviewSpawner
extends Node


var active: bool = false

@export var character_factory: CharacterFactory

@export var preview_viewport: SubViewport
@export var preview_cam: Camera3D
@export var icon_viewport: SubViewport
@export var icon_cam: Camera3D

@export var zoom_holder: Node3D
@export var unzoom_holder: Node3D

var spawned_character: CharacterReferences
var callback: Callable

var rotation_value: int = 180
var zoom_value: int


func make_ready(_callback: Callable):
	preview_cam.make_current()
	callback = _callback
	active = true

	_spawn_character(NPCResource.new())


func _process(_delta):
	if not Engine.is_editor_hint():
		return

	if not active:
		return
	
	#spawned_character.basis = Basis()
	#spawned_character.rotate(Vector3.UP, deg_to_rad(180 + rotation_value))

	var img = preview_viewport.get_texture() as Texture2D
	callback.call(img)


func _set_rotation(_value):
	rotation_value = _value


func _set_zoom(_value := 0.0):
	preview_cam.position = zoom_holder.position.lerp(unzoom_holder.position, 1 - _value)


func _spawn_character(character_resource: NPCResource):
	spawned_character = character_factory.spawn_character(character_resource) as CharacterReferences
	add_child(spawned_character)


func _edit_character(_character_resource: NPCResource):
	spawned_character.queue_free()
	_spawn_character(_character_resource)


func create_button_icon(mesh, rotate: bool) -> Texture:
	icon_cam.current = true
	spawned_character.set_preview_mode(true)
	spawned_character.preview_mesh.mesh = mesh

	spawned_character.basis = Basis()
	if rotate:
		spawned_character.rotate(Vector3.UP, deg_to_rad(90))
	else:
		spawned_character.rotate(Vector3.UP, deg_to_rad(0))

	icon_viewport.render_target_update_mode = 1
	await RenderingServer.frame_post_draw
	var image = icon_viewport.get_texture().get_image()

	spawned_character.set_preview_mode(false)
	spawned_character.rotate(Vector3.UP, deg_to_rad(180 + rotation_value))
	
	preview_cam.current = true
	return ImageTexture.create_from_image(image)


func _cleanup():
	spawned_character.queue_free()
	active = false
