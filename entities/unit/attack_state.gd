extends State


@export var ai_controller: Node3D

var target: Node3D


func _on_enter(msg := {}):
	target = msg.target


func _on_process(_delta: float):
	pass


func _on_physics_process(_delta: float):
	if not target:
		fsm_owner.transition_to("SearchState")
		return
	
	var distance_squared := ai_controller.global_position.distance_squared_to(target.global_position)
	if distance_squared > ai_controller.body.golfer_resource.role.desired_distance * ai_controller.body.golfer_resource.role.desired_distance:
		fsm_owner.transition_to("GotoState", { "target": target})
		return
