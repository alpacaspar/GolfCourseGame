extends ScrollContainer


@export var item_list = []

var current_int: int = 0


func _ready():
	for n in item_list:
		n.pressed.connect(self._on_click)


func _process(delta):
	pass


func _on_click(index: int):
	for n in item_list:
		if  n.index == index:
			continue
		
		item_list.button_pressed = false
