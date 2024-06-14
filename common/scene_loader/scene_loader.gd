extends Resource


signal on_request_scene_load(scenes: Array[PackedScene])


func load_scenes(scenes: Array[PackedScene]):
	on_request_scene_load.emit(scenes)
