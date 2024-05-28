extends Control


@export var inventory: PlayerTeamResource
@export var golfers: Array[GolferResource]
@export var icon_ps: PackedScene

@export var team_icon_holder: Control
@export var bench_icon_holder: Control

@export var continue_button: Button
@export var info_holder: Control

var team_icons: Array[UnitIcon] = []
var pickable_icons: Array[UnitIcon] = []


func _ready():
	continue_button.pressed.connect(_continue)

	for golfer in golfers:
		inventory.add_golfer(golfer)

	for x in 5:
		var icon = icon_ps.instantiate()
		team_icon_holder.add_child(icon)
		team_icons.append(icon)
		
		if x == 0:
			icon.set_values(inventory.player)
			icon.button.interactable = false
		else: if inventory.team.size() - 1 > x:
			icon.set_values(inventory.team[x])
		else:
			icon.set_empty()

		icon.callback = Callable(_button_signal)

	for golfer in inventory.get_non_team_golfers():
		var icon = icon_ps.instantiate()
		bench_icon_holder.add_child(icon)
		icon.set_values(golfer)
		pickable_icons.append(icon)
		icon.callback = Callable(_button_signal)


var selected_icon: UnitIcon
func _button_signal(icon: UnitIcon):
	if selected_icon == null: # if there is no icon currently selected, select the clicked icon
		selected_icon = icon
		info_holder.set_values(icon.current_golfer)
	else: # if an icon is selected
		if icon == selected_icon:
			icon.button.button_pressed = false # Unleselect the button on the ui
			selected_icon = null # Unselect the icon in code
			info_holder.hide_ui()
			return

		var old_golfer = icon.current_golfer # Grab the golfer on the second clicked icon
		var new_golfer = selected_icon.current_golfer # Grab the golfer on the first clicked icon

		icon.set_values(new_golfer) # Set the golfer on the second clicked icon, with the first clicked
		if old_golfer == null:
			selected_icon.queue_free()
		else:
			selected_icon.set_values(old_golfer) # Set the golfer on the first clicked icon, with the second clicked

		icon.button.button_pressed = false # Unselect the button on the ui
		selected_icon = null # Unselect the icon in code
		info_holder.hide_ui()


func _continue():
	var picked_golfers: Array[GolferResource] = []
	for icon in team_icons:
		if icon.current_golfer != null:
			picked_golfers.append(icon.current_golfer)

	inventory.team = picked_golfers
	visible = false
