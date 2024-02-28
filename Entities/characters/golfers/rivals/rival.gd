class_name Rival
extends Golfer
## A [Golfer] that the player can compete against.


## The Rival's team [b]excluding[/b] the Rival themselves.
@export var team_members: Array[Golfer]

## The Rival's team, [b]including[/b] the Rival themselves.
var team : Array:
	get:
		return team_members + [self]
