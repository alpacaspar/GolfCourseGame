extends Node


const ACTION_ONE_SHOT: StringName = "parameters/ActionOneShot/request"

@export var unit: Unit


func perform():
    unit.animation_tree.set(ACTION_ONE_SHOT, AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
