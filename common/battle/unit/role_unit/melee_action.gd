extends Node


const ACTION_ONE_SHOT: StringName = "parameters/ActionOneShot/request"


func perform(performer: Unit):
    performer.animation_tree.set(ACTION_ONE_SHOT, AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)