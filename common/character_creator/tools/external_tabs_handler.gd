extends TabContainer


@export var button_group: ButtonGroup


func _ready():
	for button in button_group.get_buttons():
		button.pressed.connect(_change_tab)


func _change_tab():
	var x: int = 0
	for button in button_group.get_buttons():
		if button.button_pressed:
			current_tab = x
			print(x)
			return
		
		x += 1
