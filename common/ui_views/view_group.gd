class_name ViewGroup
extends Resource


var view_stack: Array[View] = []


func push_view(screen: View):
	if not view_stack.is_empty():
		view_stack.front()._close()
	
	view_stack.push_front(screen)
	view_stack.front()._open()


func pop_view():
	view_stack.pop_front()._close()
	if not view_stack.is_empty():
		view_stack.front()._open()


func clear_views():
	view_stack.pop_front()._close()
	view_stack.clear()
