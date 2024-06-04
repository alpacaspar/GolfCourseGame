extends Control


func _ready():
	get_tree().current_scene.resized.connect(_on_scale)


func _on_scale():
	var standard_resolution = Vector2(1152, 648)
	var current_resolution = get_tree().root.size
	var scale_x = current_resolution.x / standard_resolution.x
	var scale_y = current_resolution.y / standard_resolution.y

	scale = Vector2(scale_x, scale_y)
   
	print(standard_resolution, current_resolution, " Scale:", scale,)
