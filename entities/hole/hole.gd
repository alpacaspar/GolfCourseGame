class_name Hole
extends Node


@onready var tee_area: Node3D = $TeeArea
@onready var green: Node3D = $GreenArea

# TODO: Use interaction through rival instead.
@export var test_player: TeamResource
@export var test_rival: TeamResource


# TODO: Remove this.
func _ready():
	BattleManager.start_battle(self, test_player, test_rival)


# TODO: Add camera animation function.
