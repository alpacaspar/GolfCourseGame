extends Node


@export var scene_loader: Resource
@export var default_scenes: Array[PackedScene] = []

var loaded_scenes: Array[Node] = []


func _enter_tree():
	scene_loader.on_request_scene_load.connect(load_scenes)

	scene_loader.load_scenes(default_scenes)


func load_scenes(scenes: Array[PackedScene]):
	for scene: Node in loaded_scenes:
		scene.queue_free()

	for scene: PackedScene in scenes:
		var instance: Node = scene.instantiate()
		add_child(instance)

		loaded_scenes.append(instance)
