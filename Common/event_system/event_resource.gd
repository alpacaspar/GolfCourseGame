class_name EventResource
extends Resource


var callable_dict := {}


func add_callable(_callable_name : String, _callable : Callable):
	callable_dict[_callable_name] = _callable


func remove_callable(_callable_name : String):
	if callable_dict.has(_callable_name):
		callable_dict.erase(_callable_name)


func call_callable(_callable_name: String):
	callable_dict[_callable_name].call()


func call_callable_one_arg(_callable_name: String, arg1):
	callable_dict[_callable_name].call(arg1)


func call_callable_two_args(_callable_name: String, arg1, arg2):
	callable_dict[_callable_name].call(arg1, arg2)
		
