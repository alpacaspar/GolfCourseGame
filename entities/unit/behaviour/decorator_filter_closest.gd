extends BTDecorator


@export var input_array: StringName = "entities"


func _decorate(blackboard: Dictionary):
    var entities: Array[Node3D] = blackboard[input_array]
    var unit: Unit = blackboard["unit"]

    var distance_squared := INF
    var result: Node3D

    for entity: Node3D in entities:
        if entity == unit:
            continue

        var distance := unit.global_position.distance_squared_to(entity.global_position)
        if distance < distance_squared:
            distance_squared = distance
            result = entity

    if not result:
        return

    entities.clear()
    entities.append(result)
