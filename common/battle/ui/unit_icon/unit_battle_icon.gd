extends Control


@export var screen_group: ScreenGroup
@export var screen: Screen


@onready var unit_portrait: TextureRect = $UnitPortrait
@onready var stamina_bar: ProgressBar = $ProgressBar

var data: GolferResource


func _ready():
	await get_tree().create_timer(3).timeout
	
	screen_group.open_screen(screen)


func set_data(golfer_data: GolferResource):
	data = golfer_data
	unit_portrait.texture = data.npc_resource.icon
	
	data.on_stamina_changed.connect(_on_stamina_changed)


func _on_stamina_changed(new_value: int):
	stamina_bar.value = new_value
