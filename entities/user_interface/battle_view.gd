extends View


@export var team_one_container: Control
@export var team_two_container: Control

@export var unit_battle_icon_scene: PackedScene


func _ready():
	BattleManager.on_battle_started.connect(_on_battle_started)


func _open():
	visible = true


func _close():
	visible = false


func _on_battle_started(teams: Array[Team]):
	for child: Control in team_one_container.get_children():
		child.queue_free()
	
	for child: Control in team_two_container.get_children():
		child.queue_free()
	
	var team_one: Team = teams[0]
	var team_two: Team = teams[1]

	for unit: Unit in team_one.units:
		var icon: Control = unit_battle_icon_scene.instantiate()
		team_one_container.add_child(icon)
		icon.set_data(unit.golfer_resource)
	
	for unit: Unit in team_two.units:
		var icon: Control = unit_battle_icon_scene.instantiate()
		team_two_container.add_child(icon)
		icon.set_data(unit.golfer_resource)
	
	view_group.push_view(self)
