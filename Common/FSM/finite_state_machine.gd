class_name FSM
extends Node


var states = {}

var current_state : State


func _ready():
	for state in get_children():
		states[state.name] = state
	
	current_state = get_child(0)


func _input(event):
	if current_state != null:
		current_state._on_input(event, self)


func _process(delta):
	if current_state != null:
		current_state._on_process(delta, self)


func _physics_process(delta):
	if current_state != null:
		current_state._on_physics_process(delta, self)


func _transition_state(new_state : State, _args = {}):
	if current_state != null:
		current_state._on_exit(_args)
	
	current_state = new_state
	current_state._on_enter(self, _args)
