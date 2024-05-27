extends Control


@export var golfers: Array[GolferResource]
@export var icon_ps: PackedScene

@export var team_icon_holder: Control
@export var bench_icon_holder: Control

var team_icons: Array[UnitIcon] = []
var pickable_icons: Array[UnitIcon] = []


func _ready():
	for golfer in golfers:
		Inventory.add_golfer(golfer)

	for x in 5:
		var icon = icon_ps.instantiate()
		team_icon_holder.add_child(icon)
		team_icons.append(icon)
		
		if Inventory.current_team.size() - 1 > x:
			icon.set_values(Inventory.current_team[x])
		else:
			icon.set_empty()

		icon.callback = Callable(_button_signal)

	for golfer in Inventory.get_non_team_golfers():
		var icon = icon_ps.instantiate()
		bench_icon_holder.add_child(icon)
		icon.set_values(golfer)
		pickable_icons.append(icon)
		icon.callback = Callable(_button_signal)


var selected_icon: UnitIcon
func _button_signal(icon: UnitIcon):
	if selected_icon == null: # if there is no icon currently selected, select the clicked icon
		selected_icon = icon
	else: # if an icon is selected
		if icon == selected_icon:
			icon.button.selected = false # Unleselect the button on the ui
			selected_icon = null # Unselect the icon in code
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
