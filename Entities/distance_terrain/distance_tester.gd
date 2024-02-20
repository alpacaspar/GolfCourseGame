extends Node3D


@export var block : PackedScene


func _ready():
	for n in 400:
		if n < 1:
			for cm in 10:
				var tmp = block.instantiate() as Node3D
				add_child(tmp)
				tmp.global_position = Vector3(float(cm) / 10.0, 0, 0)
				tmp.get_child(0).set_text("")
			
			continue
		
		if n < 10:
			var tmp = block.instantiate() as Node3D
			add_child(tmp)
			tmp.global_position = Vector3(n, 0, 0)
			tmp.get_child(0).set_text(str(n) + "m")
			continue
		
		if n % 5 == 0:
			var tmp = block.instantiate() as Node3D
			add_child(tmp)
			tmp.global_position = Vector3(n, 0, 0)
			tmp.get_child(0).set_text(str(n) + "m")
