extends RigidBody3D


const VELOCITY_DAMAGE_THRESHOLD = 1.0
const PROJECTILE_SPEED = 20.0

@export_flags_3d_physics var sensor_collision_mask := 1

var last_user: Unit

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")


func hit(originator: Unit):
    last_user = originator

    var target_position := Vector3.ZERO
    var average_velocity := Vector3.ZERO
    var target := _find_target()

    if target:
        target_position = target.global_position
        average_velocity = target.velocity_buffer.average_velocity
    else:
        target_position = last_user.global_position + last_user.controller.basis.z * last_user.role.max_drive_range

    # If _calculate_intersection_time() fails, a 0 is returned, in that case the prediction will default to the target's current position.
    var predicted_target_position := target_position + average_velocity * _calculate_intersection_time(global_position, target_position, average_velocity)
    var delta: Vector3 = (predicted_target_position + Vector3.UP) - global_position

    # A launch angle of 0 degrees will go straight ahead, which is fine for closer targets.
    var launch_angle := _calculate_launch_angle(PROJECTILE_SPEED, gravity, Vector2(delta.x, delta.z).length(), delta.y)
    if launch_angle > deg_to_rad(60):
        launch_angle = 0.0

    var sx := PROJECTILE_SPEED * cos(launch_angle)
    var sy := PROJECTILE_SPEED * sin(launch_angle)

    var horizontal_delta: Vector3 = predicted_target_position - global_position
    horizontal_delta.y = 0

    var launch_force := horizontal_delta.normalized() * sx + Vector3.UP * sy

    linear_velocity = Vector3.ZERO
    apply_impulse(launch_force)


func _on_body_entered(body: Node3D):
    if body == last_user:
        return

    if linear_velocity.length_squared() < VELOCITY_DAMAGE_THRESHOLD * VELOCITY_DAMAGE_THRESHOLD:
        return

    if body.has_method("try_take_damage"):
        body.try_take_damage(self, last_user.golfer_resource.power)
 

func _find_target() -> Node3D:
    var space_state := last_user.get_world_3d().direct_space_state
    var query := _get_query(last_user, last_user.role.max_drive_range)

    var intersections: Array[Dictionary] = space_state.intersect_shape(query)

    for i: int in range(intersections.size() - 1, -1, -1):
        var collider: Node3D = intersections[i]["collider"]
        if not collider.is_in_group("unit"):
            intersections.remove_at(i)

        var direction_to_ball := last_user.global_position.direction_to(global_position)
        var direction_to_collider := last_user.global_position.direction_to(collider.global_position)
        if direction_to_ball.angle_to(direction_to_collider) > deg_to_rad(last_user.role.max_drive_angle):
            intersections.remove_at(i)

    ## Find intersection with smallest angle between originator's forward vector and the direction to the target.
    var target: Node3D = null
    var min_angle := INF

    for intersection: Dictionary in intersections:
        var direction_to_collider := last_user.global_position.direction_to(intersection["collider"].global_position)
        var angle := last_user.controller.basis.z.angle_to(direction_to_collider)
        if angle < min_angle:
            min_angle = angle
            target = intersection["collider"]

    return target


func _get_query(request_node: CollisionObject3D, radius: float) -> PhysicsShapeQueryParameters3D:
    var shape_rid := PhysicsServer3D.sphere_shape_create()
    PhysicsServer3D.shape_set_data(shape_rid, radius)

    var params := PhysicsShapeQueryParameters3D.new()
    params.shape_rid = shape_rid
    params.transform = request_node.global_transform
    params.collision_mask = sensor_collision_mask
    params.exclude = [request_node.get_rid()]

    return params


func _calculate_intersection_time(origin: Vector3, target_position: Vector3, average_velocity: Vector3) -> float:
    # Quadratic formula business.
    var a := average_velocity.dot(average_velocity) - PROJECTILE_SPEED * PROJECTILE_SPEED
    var b := 2 * (target_position - origin).dot(average_velocity)
    var c := (target_position - origin).length_squared()

    if a == 0:
        return -c / b

    var discriminant := b * b - 4 * a * c
    if discriminant < 0:
        return 0.0
    elif discriminant == 0:
        return -b / (2 * a)

    var t1 := (-b + sqrt(discriminant)) / (2 * a)
    var t2 := (-b - sqrt(discriminant)) / (2 * a)

    # Negative values are considered invalid.
    if t1 < 0 or t2 < 0:
        return max(t1, t2)

    return min(t1, t2)


func _calculate_launch_angle(v: float, g: float, x: float, y: float) -> float:
    var discriminant := v**4 - g * (g * x**2 + 2 * y * v**2)
    if discriminant < 0:
        return 0.0
    elif discriminant == 0:
        return atan2(v**2 / (g * x), x)

    var t1 := atan((v**2 + sqrt(discriminant)) / (g * x))
    var t2 := atan((v**2 - sqrt(discriminant)) / (g * x))

    return min(t1, t2)
