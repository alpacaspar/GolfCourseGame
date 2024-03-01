class_name DetectionArea3D
extends Area3D
## Helper node for detecting entities in a 3D area.


## Get [Array] of [Vector3] positions of all characters that are overlapping with this area.
var overlapping_character_positions: Array[Vector3]:
    get:
        var result: Array[Vector3] = []

        for body in get_overlapping_bodies():
            result.append(body.global_position)

        return result
