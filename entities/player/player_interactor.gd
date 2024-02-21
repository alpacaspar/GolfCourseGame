extends Interactor


@export var player: CharacterBody3D

var cached_closest: Interactable


func _ready():
    controller = player


func _physics_process(_delta: float):
    var new_closest := get_closest_interactable()
    if new_closest != cached_closest:
        if is_instance_valid(cached_closest):
            unfocus(cached_closest)
        
        if new_closest:
            focus(new_closest)

        cached_closest = new_closest


func _input(event: InputEvent):
    if event.is_action_released("interact"):
        if cached_closest:
            interact(cached_closest)


func _on_area_entered(area: Interactable):
    if cached_closest == area:
        focus(area)


func _on_area_exited(area: Interactable):
    if cached_closest == area:
        unfocus(area)
