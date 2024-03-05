@tool
class_name DialogOption
extends Control


@export var move_button: Button
@export var remove_button: Button

var given_callable


func setup(remove_callback, move_callback):
	given_callable = remove_callback

	remove_button.pressed.connect(_run_remove)
	move_button.pressed.connect(move_callback)


func _run_remove():
	given_callable.call(self)