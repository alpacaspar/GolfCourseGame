class_name Battle
extends Node3D


@export var battle_name: String
@export var rival_team: TeamResource

@export var camera_path_track: PathFollow3D

@export var ball_spawnpoints: Array[Marker3D] = []

@onready var tee_area: Node3D = $TeeArea
@onready var green: Node3D = $GreenArea


# TODO: Play sequence instead.
func play_intro_sequence():
	var tween := create_tween()

	camera_path_track.get_child(0).set_current(true)
	tween.tween_property(camera_path_track, "progress_ratio", 0.95, 16).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_callback(func(): camera_path_track.get_child(0).clear_current())
	tween.tween_callback(func(): tee_area.get_child(0).make_current())
	tween.tween_interval(4)
	tween.tween_callback(func(): tee_area.get_child(0).clear_current())
	tween.tween_callback(func(): green.get_child(0).make_current())
	tween.tween_interval(4)
	tween.tween_callback(func(): green.get_child(0).clear_current())

	await tween.finished
