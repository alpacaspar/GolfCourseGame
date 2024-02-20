extends State


@export var golf_manager : Node3D

var current_position : float
var last_position : float

var largest_negative : float
var speed : float
var highest_speed : float


func _on_enter(_owner : FSM, _args = {}):
	current_position = 0


func _on_input(_event, _owner : FSM):
	if _event is InputEventMouseMotion:
		current_position += _event.get_relative().y


func _on_process(_delta, _owner : FSM):
	largest_negative = current_position if current_position > largest_negative else largest_negative
	
	if current_position != last_position:
		speed = abs(current_position - last_position) * _delta
		last_position = current_position
		
		if speed > 6:
			speed = 6
	
	var normalized_speed = speed / 6.0
	
	if Input.is_action_pressed("Mouse0") and current_position < 0:
		golf_manager.hit_ball(normalized_speed)
