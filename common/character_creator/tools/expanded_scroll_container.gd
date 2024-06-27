extends ScrollContainer


@export var show_slider: bool
@export var slider: ScrollBar

var last_val = 0


func _ready():
	if slider != null:	
		if !show_slider:
			slider.visible = false
			get_child(1).get_child(2).visible = false
		
		slider.value_changed.connect(_scroll)


func _process(_delta):
	if last_val != scroll_vertical:
		_scroll(scroll_vertical)

	slider.max_value = get_child(0).size.y - size.y
	last_val = scroll_vertical


func _scroll(value := 0):
	scroll_vertical = value
	slider.value = value
