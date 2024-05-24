extends Node


const ACTION_ONE_SHOT: StringName = "parameters/ActionOneShot/request"

var unit: Unit:
    get:
        if not unit:
            unit = get_parent()

        return unit


func perform():
    unit.animation_tree.set(ACTION_ONE_SHOT, AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
