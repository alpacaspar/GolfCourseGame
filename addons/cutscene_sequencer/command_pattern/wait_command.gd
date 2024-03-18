class_name WaitCommand
extends Command


var set_timer: float = 0.0


static func create_new(timer: float) -> WaitCommand:
	var command = WaitCommand.new()
	command.set_timer = timer
	
	return command


func run_command():
	await get_tree().create_timer(set_timer).timeout

	is_done = true
