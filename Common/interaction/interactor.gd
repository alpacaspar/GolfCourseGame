class_name Interactor
extends Area3D


var controller: Node3D


func interact(interactable: Interactable):
	interactable.interacted.emit(self)


func focus(interactable: Interactable):
	interactable.on_focus.emit(self)


func unfocus(interactable: Interactable):
	interactable.on_unfocus.emit(self)


func get_closest_interactable() -> Interactable:
	var interactables := get_overlapping_areas()
	var distance: float
	var closest_distance := INF
	var closest: Interactable

	for interactable: Interactable in interactables:
		distance = interactable.global_position.distance_to(global_position)
		
		if distance < closest_distance:
			closest_distance = distance
			closest = interactable

	return closest
