class_name Hole
extends Node


@onready var tee_area: Node3D = $TeeArea
@onready var green: Node3D = $GreenArea

@export var test_player: RivalResource
@export var test_rival: RivalResource


# TODO: Remove this.
func _ready():
    BattleManager.start_battle(self, test_player, test_rival)


# TODO: Add camera animation function.
