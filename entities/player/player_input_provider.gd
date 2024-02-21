class_name PlayerInputProvider
extends InputProvider


signal on_look(input_delta: Vector2)

@export var player: CharacterBody3D

var move: Vector2
var look: Vector2


func _on_enter():
	player.make_camera_current(true)


func _on_exit():
	player.make_camera_current(false)


func _on_input(event: InputEvent):
	if event is InputEventMouseMotion:
		on_look.emit(event.relative)


func _on_process():
	move = Input.get_vector("move_left", "move_right", "move_up", "move_down")
