extends TabContainer


@export var button_group: ButtonGroup


func _ready():
	for button: BaseButton in button_group.get_buttons():
		button.pressed.connect(_change_tab)


func _change_tab():
	var x := 0
	for button: BaseButton in button_group.get_buttons():
		if button.button_pressed:
			current_tab = x
			return
		
		x += 1
