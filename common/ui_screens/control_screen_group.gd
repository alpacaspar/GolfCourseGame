class_name ScreenGroup
extends Resource


@export var screens: Array[Screen] = []


func open_screen(screen_to_open: Screen):
	for screen: Screen in screens:
		screen.close()
	
	screen_to_open.open()


func close_screen(screen_to_close: Screen):
	var index := screens.find(screen_to_close)
	
	if index >= 0:
		screens[index].close()
