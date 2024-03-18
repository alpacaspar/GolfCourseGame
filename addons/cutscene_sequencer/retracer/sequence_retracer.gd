extends Node


var sequence: Array[Command]


func _ready():
		start_sequence([WaitCommand.create_new(2.0), WaitCommand.create_new(2.0), WaitCommand.create_new(2.0)])


func start_sequence(sequence: Array[Command]):
	for command: Command in sequence:
		print("Next Command")
		
		add_child(command)
		await command.run_command()
		command.queue_free()

	print("DONE!")
