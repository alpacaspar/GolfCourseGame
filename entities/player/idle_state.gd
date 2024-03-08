extends State


@export var player: CharacterBody3D


func _on_enter(_msg := {}):
	pass


func _on_input(_event: InputEvent):
	pass


func _on_process(_delta: float):
	pass


func _on_physics_process(delta: float):
	player.velocity.y = -1 if player.is_on_floor() else player.velocity.y - player.gravity * delta
	
	# This function already uses the delta time internally.
	player.move_and_slide()


func _on_exit():
	pass
