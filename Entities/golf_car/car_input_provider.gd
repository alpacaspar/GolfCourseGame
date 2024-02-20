class_name CarInputProvider
extends InputProvider


signal on_look(input_delta: Vector2)

@export var camera: Camera3D

var move: Vector2
var look: Vector2


func _on_enter():
	camera.make_current()


func _on_exit():
	pass


func _on_input(event: InputEvent):
	if event is InputEventMouseMotion:
		on_look.emit(event.relative)


func _on_process():
	move = Input.get_vector("move_left", "move_right", "move_up", "move_down")
