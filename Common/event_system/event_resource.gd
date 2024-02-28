class_name EventResource
extends Resource


var listeners: Array[Callable] = []


func add_listener(callable: Callable):
	listeners.append(callable)


func remove_listener(callable: Callable):
	if listeners.has(callable):
		listeners.erase(callable)
 

func invoke(msg := {}):
	for listener in listeners:
		listener.call(msg)
