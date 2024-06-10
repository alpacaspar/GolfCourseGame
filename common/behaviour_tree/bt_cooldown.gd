class_name Cooldown
extends BTCondition
## A decorator that starts a cooldown every time the child node returns SUCCESS.


@export var cooldown_time := 1.0
@export var cooldown_on_ready := false

var current_time := 0.0


func _ready():
	super._ready()

	if cooldown_on_ready:
		current_time = cooldown_time


func _check_condition(_blackboard : Dictionary) -> bool:
	if current_time <= 0.0:
		current_time = cooldown_time
		return true
	
	current_time -= get_process_delta_time()
	return false
