extends State


func _on_enter(_msg := {}):
    # Await NavigationServer map synchronization.
    await get_tree().physics_frame
    
    fsm_owner.transition_to("SearchState")


func _on_input(_event: InputEvent):
    pass


func _on_unhandled_input(_event: InputEvent):
    pass


func _on_process(_delta: float):
    pass


func _on_physics_process(_delta: float):
    pass


func _on_exit():
    pass
