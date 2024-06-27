extends Control


@onready var unit_portrait: TextureRect = $UnitPortrait
@onready var stamina_bar_trail: ProgressBar = $StaminaBar/Trail
@onready var stamina_bar: ProgressBar = $StaminaBar/Fill

var data: GolferResource

var cached_value := -1
var tween: Tween


func set_data(golfer_data: GolferResource):
	data = golfer_data
	unit_portrait.texture = data.npc_resource.icon
	stamina_bar.max_value = data.stamina
	stamina_bar_trail.max_value = data.stamina

	_on_stamina_changed(data.stamina)
	data.on_stamina_changed.connect(_on_stamina_changed)


func _on_stamina_changed(new_value: int):
	stamina_bar.value = new_value
	if tween != null and tween.is_running():
		cached_value = new_value
	else:
		create_stamina_tween(new_value)


func _on_tween_finished():
	if cached_value > -1:
		create_stamina_tween(cached_value)
		cached_value = -1


func create_stamina_tween(amount: int):
	tween = create_tween()
	tween.tween_property(stamina_bar_trail, "value", amount, 0.5)
	tween.tween_callback(_on_tween_finished)
