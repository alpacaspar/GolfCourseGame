class_name FiniteStateMachine
extends BTComposite
## Simple finite state machine to be used with a [BehaviourTree].
##
## Any child that is a [BTNode] will be considered a state.
## It is important that every state has a unique name.


var states: Dictionary:
	get:
		if not states:
			for child_node in child_nodes:
				states[StringName(child_node.get_name().to_snake_case())] = child_node
		
		return states

var current_state: BTNode:
	get:
		if not current_state:
			current_state = child_nodes.front()
		
		return current_state


func tick(blackboard: Dictionary, delta: float) -> int:
	return current_state.tick(blackboard, delta)


## Transition to state with name [param state_name]. Returns [enum SUCCESS] if the state was found, [enum FAILURE] otherwise.
func transition_to(state_name: StringName) -> int:
	if not states.has(state_name):
		push_error("State not found: " + state_name)
		return FAILURE
	
	current_state = states[state_name]
	return SUCCESS