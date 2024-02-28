extends State


@export var event_resource: Resource
@export var golf_manager: Node3D

var current_position: float
var last_position: float

var current_negative: float
var largest_negative: float
var speed: float
var highest_speed: float


func _on_enter(_owner: FSM, _args := {}):
	current_position = 0


func _on_input(_event: InputEvent, _owner: FSM):
	if _event is InputEventMouseMotion:
		current_position += _event.get_relative().y


func _on_process(_delta: float, _owner: FSM):
	largest_negative = current_position if current_position > largest_negative else largest_negative
	current_negative = current_position if current_position > 0.0 else 0.0
	
	if current_position != last_position:
		speed = abs(current_position - last_position) * _delta
		last_position = current_position
		
		if speed > 6:
			speed = 6
	
	var normalized_speed = speed / 6.0
	if Input.is_action_pressed("interact") and current_position < 0:
		golf_manager.hit_ball(normalized_speed)
		set_ui_values(normalized_speed)
		return
	
	set_ui_values(0.0)


func set_ui_values(_speed_val: float):
	#event_resource.call_callable_two_args("UpdateGolfUI", current_negative / (get_window().size.y / 2.0), _speed_val)
	pass
