extends View


const TEAM_MEMBER_COUNT := 5

@export var inventory: PlayerTeamResource
@export var icon_ps: PackedScene

@export var team_icon_holder: Control
@export var bench_icon_holder: Control

@export var continue_button: Button
@export var info_holder: Control

var team_icons: Array[UnitIcon] = []
var selected_icon: UnitIcon = null


func _ready():
	continue_button.pressed.connect(_continue)

	for i: int in range(TEAM_MEMBER_COUNT):
		var icon = icon_ps.instantiate()
		team_icon_holder.add_child(icon)
		team_icons.append(icon)
		icon.callback = Callable(_button_signal)

		if i == 0:
			icon.set_values(inventory.player)
			icon.can_click = false
		elif inventory.units.size() - 1 > i:
			icon.set_values(inventory.units[i])
		else:
			icon.set_empty()

	for golfer: GolferResource in inventory.get_non_team_golfers():
		var icon = icon_ps.instantiate()
		bench_icon_holder.add_child(icon)
		icon.set_values(golfer)
		icon.callback = Callable(_button_signal)


func _open():
	visible = true


func _close():
	visible = false


func _button_signal(icon: UnitIcon, event: InputEvent):
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
			new_icon.callback = Callable(_button_signal)
			
			_deselect_icon(icon)


func _deselect_icon(icon: UnitIcon):
	icon.button.button_pressed = false
	selected_icon = null
	info_holder.hide_ui()


func transfer_golfer(from_icon: UnitIcon, to_icon: UnitIcon, golfer: GolferResource):
	if not team_icons.has(from_icon):
		from_icon.queue_free()
	else:
		from_icon.set_empty()
	to_icon.set_values(golfer)


func _continue():
	var picked_golfers: Array[GolferResource] = []
	for icon: UnitIcon in team_icons:
		if icon.current_golfer != null:
			picked_golfers.append(icon.current_golfer)

	inventory.units = picked_golfers
	view_group.pop_view()
