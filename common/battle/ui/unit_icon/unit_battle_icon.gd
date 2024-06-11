extends Control


@onready var unit_portrait: TextureRect = $UnitPortrait
@onready var stamina_bar: ProgressBar = $ProgressBar

var data: GolferResource


func set_data(golfer_data: GolferResource):
	data = golfer_data
	unit_portrait.texture = data.npc_resource.icon
	
	data.on_stamina_changed.connect(_on_stamina_changed)


func _on_stamina_changed(new_value: int):
	stamina_bar.value = new_value
