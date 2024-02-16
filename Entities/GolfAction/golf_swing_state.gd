extends State


@export var golf_manager : Node3D

var current_position : float
var last_position : float

var largest_negative : float
var speed : float


func _on_enter(_owner : FSM, _args = {}):
	current_position = 0


func _on_input(_event, _owner : FSM):
	if _event is InputEventMouseMotion:
		current_position += _event.get_relative().y


func _on_process(_delta, _owner : FSM):
	largest_negative = current_position if current_position > largest_negative else largest_negative
	speed = abs(current_position - last_position)
	last_position = current_position
	
	if Input.is_action_pressed("Mouse0"):
		if speed > 50 && current_position < 0:
			golf_manager.hit_ball(speed)


func _on_physics_process(_delta, _owner : FSM):
	pass


func _on_exit(_args = {}):
	pass
