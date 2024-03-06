@tool
class_name PreviewSpawner
extends Node


var active: bool = false

@export var character_factory: CharacterFactory

@export var viewport: SubViewport
@export var preview_cam: Camera3D

@export var zoom_holder: Node3D
@export var unzoom_holder: Node3D

var spawned_character: Node3D
var callback: Callable

var rotation_value: int
var zoom_value: int


func _make_ready(_callback: Callable):
	preview_cam.make_current()
	callback = _callback
	active = true

	_spawn_character(NPCResource.new())


func _process(_delta):
	if not Engine.is_editor_hint():
		return

	if not active:
		return
	
	spawned_character.basis = Basis()
	spawned_character.rotate(Vector3.UP, deg_to_rad(rotation_value))

	var img = viewport.get_texture() as Texture2D
	callback.call(img)


func _set_rotation(_value):
	rotation_value = _value


func _set_zoom(_value := 0.0):
	preview_cam.position = zoom_holder.position.lerp(unzoom_holder.position, 1 - _value)


func _spawn_character(character_resource: NPCResource):
	spawned_character = character_factory.spawn_character(character_resource)
	add_child(spawned_character)


func _edit_character(_character_resource: NPCResource):
	spawned_character.queue_free()
	_spawn_character(_character_resource)


func _cleanup():
	spawned_character.queue_free()
	active = false
