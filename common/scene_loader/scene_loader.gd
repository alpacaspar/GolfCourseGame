extends Resource


signal on_request_scene_load(scenes: Array[SceneReference])


func load_scenes(scenes: Array[SceneReference]):
	on_request_scene_load.emit(scenes)
