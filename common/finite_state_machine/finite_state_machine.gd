class_name FSM
extends Node


var states := {}

var current_state: State


func _ready():
	for state: State in get_children():
		state.fsm_owner = self
		states[state.name] = state
	
	current_state = get_child(0) as State
	current_state._on_enter()


func _input(event):
	if current_state:
		current_state._on_input(event)


func _unhandled_input(event: InputEvent):
	if current_state:
		current_state._on_unhandled_input(event)


func _process(delta):
	if current_state:
		current_state._on_process(delta)


func _physics_process(delta):
	if current_state:
		current_state._on_physics_process(delta)


func transition_to(new_state: String, msg := {}):
	if current_state:
		current_state._on_exit()
	
	current_state = states[new_state]
	current_state._on_enter(msg)
