@tool
class_name NPCDock
extends Control


@export var npc_resource: ResourceLoadingHandler
@export var golfer_resource: ResourceLoadingHandler


func _ready():
	npc_resource._set_value()
	golfer_resource._set_value()


func _process(delta):
	pass


func _save_npc_resource():
	pass

	
func _load_npc_resource():
	pass
