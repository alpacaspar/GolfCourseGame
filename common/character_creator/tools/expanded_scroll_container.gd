extends ScrollContainer


@export var show_slider: bool
@export var slider: ScrollBar

@export var slider_grab_sound: String
@export var slider_ungrab_sounds: String

var last_val = 0


func _ready():
	if slider != null:
		if !show_slider:
			slider.visible = false
			get_child(1).get_child(2).visible = false
		
		# slider.drag_started.connect(play_slider_grab_sound)
		# slider.drag_ended.connect(play_slider_ungrab_sound)
		slider.value_changed.connect(_scroll)


func _process(_delta):
	if last_val != scroll_vertical:
		_scroll(scroll_vertical)

	slider.max_value = get_child(0).size.y - size.y
	slider.page = slider.max_value / 5
	last_val = scroll_vertical


func _scroll(value := 0):
	scroll_vertical = value
	slider.value = value


func play_slider_grab_sound(): Wwise.post_event(slider_grab_sound, self)
func play_slider_ungrab_sound(_value): Wwise.post_event(slider_ungrab_sounds, self)
