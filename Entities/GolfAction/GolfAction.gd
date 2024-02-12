extends Node3D


@export var ballScene : PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	var ball = ballScene.instantiate()
	add_child(ball);
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
