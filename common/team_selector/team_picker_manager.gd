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
		inventory.add_to_bench(golfer)

	for x in 5:
		var icon = icon_ps.instantiate()
		team_icon_holder.add_child(icon)
		team_icons.append(icon)
		icon.callback = Callable(_button_signal)

		if x == 0:
			icon.set_values(inventory.player)
			icon.can_click = false
		elif inventory.team.size() - 1 > x:
			icon.set_values(inventory.team[x])
		else:
			icon.set_empty()

	for golfer in inventory.get_non_team_golfers():
		var icon = icon_ps.instantiate()
		bench_icon_holder.add_child(icon)
		icon.set_values(golfer)
		pickable_icons.append(icon)
		icon.callback = Callable(_button_signal)


var selected_icon: UnitIcon = null
func _button_signal(icon, event):
	if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if selected_icon == null: # No icon currently selected, select the clicked icon
			selected_icon = icon
			if icon.current_golfer != null:
				info_holder.set_values(icon.current_golfer)
		else:
			if icon == selected_icon:
				_deselect_icon(icon) # Deselect the current icon
			else:
				var old_golfer = icon.current_golfer
				var new_golfer = selected_icon.current_golfer

				if old_golfer == null and new_golfer != null:
					transfer_golfer(selected_icon, icon, new_golfer)
				elif new_golfer == null and old_golfer != null:
					transfer_golfer(icon, selected_icon, old_golfer)
				elif new_golfer != null and old_golfer != null:
					icon.set_values(new_golfer)
					selected_icon.set_values(old_golfer)

				_deselect_icon(icon)
	elif event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		if team_icons.has(icon) && icon.current_golfer != null:
			var golfer = icon.current_golfer
			var new_icon = icon_ps.instantiate()

			icon.set_empty()

			bench_icon_holder.add_child(new_icon)
			new_icon.set_values(golfer)
			pickable_icons.append(new_icon)
			new_icon.callback = Callable(_button_signal)
			
			_deselect_icon(icon)


func _deselect_icon(icon):
	icon.button.button_pressed = false
	selected_icon = null
	info_holder.hide_ui()


func transfer_golfer(from_icon: UnitIcon, to_icon: UnitIcon, golfer):
	if not team_icons.has(from_icon):
		from_icon.queue_free()
	else:
		from_icon.set_empty()
	to_icon.set_values(golfer)


func _continue():
	var picked_golfers: Array[GolferResource] = []
	for icon in team_icons:
		if icon.current_golfer != null:
			picked_golfers.append(icon.current_golfer)

	inventory.team = picked_golfers
	visible = false
