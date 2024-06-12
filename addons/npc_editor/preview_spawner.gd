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

var spawned_character: Character
var callback: Callable

var rotation_value: int = 180

var getting_icons: bool
var zoom_target: Vector3
var zoom_value: float


func make_ready():
	preview_cam.make_current()

	_spawn_character(NPCResource.new())
	zoom_target = zoom_holder_face.position


func on_process(_delta):	
	if !getting_icons:
		spawned_character.basis = Basis()
		spawned_character.rotate(Vector3.UP, deg_to_rad(180 + rotation_value))

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


func _spawn_character(character_resource: NPCResource):
	spawned_character = CharacterFactory.spawn_character(character_resource) as Character
	add_child(spawned_character)
	spawned_character.position = character_spawn_position.position


func _edit_character(character_resource: NPCResource):
	spawned_character.queue_free()
	_spawn_character(character_resource)


func _exit_tree():
	spawned_character.queue_free()
