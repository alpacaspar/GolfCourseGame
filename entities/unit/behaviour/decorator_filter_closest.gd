extends BTDecorator


func _decorate(blackboard: Dictionary):
    var entities: Array[Unit] = blackboard["entities"]
    var unit: Unit = blackboard["unit"]

    var distance_squared := INF
    var result: Unit

    for entity: Unit in entities:
        if entity == unit:
            continue

        var distance := unit.global_transform.origin.distance_squared_to(entity.global_transform.origin)
        if distance < distance_squared:
            distance_squared = distance
            result = entity
    
    if not result:
        return

    entities.clear()
    entities.append(result)
