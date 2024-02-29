class_name RivalResource
extends GolferResource
## A [GolferResource] that the player can compete against.


## The RivalResource's team [b]excluding[/b] the RivalResource themselves.
@export var team_members: Array[GolferResource]

## The RivalResource's team, [b]including[/b] the RivalResource themselves.
var team : Array:
	get:
		return team_members + [self]
