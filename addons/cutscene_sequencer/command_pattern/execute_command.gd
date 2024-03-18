class_name ExecuteCommand
extends Command


var set_callback: Signal


static func create_new(callback: Signal) -> ExecuteCommand:
	var command = ExecuteCommand.new()
	command.set_callback = callback
	
	return command


func run_command():
	await set_callback.emit()

	is_done = true
