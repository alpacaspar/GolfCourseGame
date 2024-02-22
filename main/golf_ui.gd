extends Control


@export var event_resource: EventResource

@export var back_swing: ProgressBar
@export var front_swing: ProgressBar


func _ready():
	event_resource.add_callable("UpdateGolfUI", Callable(set_golf_swing_ui))


func _process(_delta):
	pass


func set_golf_swing_ui(_back_swing_value: float, _front_swing_value: float):
	back_swing.value = _back_swing_value
	front_swing.value = _front_swing_value
