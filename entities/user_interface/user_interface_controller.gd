extends Control


@export var _interface_dictionary := {}


func switch_interface(key: StringName, additive := false):
	if not _interface_dictionary.has(key):
		return
	
	if not additive:
		for interface: Control in _interface_dictionary.values():
			interface.set_visible(false)
	
	_interface_dictionary[key].set_visible(true)
