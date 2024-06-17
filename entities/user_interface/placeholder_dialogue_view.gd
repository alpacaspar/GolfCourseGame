extends View


@export var team_picker_view: Node
@export var battle_to_start: PackedScene


func _ready():
	view_group.push_view(self)


func _open():
	visible = true


func _close():
	visible = false


func _on_accept_button_pressed():
	view_group.push_view(team_picker_view)


func _on_start_battle_button_pressed():
	view_group.pop_view()
	BattleManager.start_battle(battle_to_start)
