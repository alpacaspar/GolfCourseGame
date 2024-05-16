extends Node


const PROJECTILE_SPEED = 30
const PREDICTION_BUFFER_SIZE = 5

@export var golf_ball: PackedScene

var unit: Unit:
    get:
        if not unit:
            unit = get_parent()

        return unit

var current_target: Unit

## Buffer storing the velocity of the target of the past 5 frames.
var velocity_buffer: Array[Vector3] = []
var average_velocity: Vector3:
    get:
        var sum = Vector3.ZERO
        for velocity in velocity_buffer:
            sum += velocity

        return sum / velocity_buffer.size()


var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

var ball: RigidBody3D


func _physics_process(_delta: float):
    if current_target != unit.target:
        current_target = unit.target
        velocity_buffer.clear()

    if not current_target:
        return

    if velocity_buffer.size() < 12:
        velocity_buffer.pop_back()

    velocity_buffer.push_front(current_target.get_real_velocity())


func perform():
    if not unit.character.primary_animation_event.is_connected(_on_primary_animation_event):
        unit.character.primary_animation_event.connect(_on_primary_animation_event)
    
    if not unit.character.secondary_animation_event.is_connected(_on_secondary_animation_event):
        unit.character.secondary_animation_event.connect(_on_secondary_animation_event)


func _on_primary_animation_event():
    ball = golf_ball.instantiate()
    ball.owning_unit = unit
    add_child(ball)
    ball.global_position = unit.character.left_hand_marker.global_position


func _on_secondary_animation_event():
    # If _calculate_intersection_time() fails, a 0 is returned, in that case the prediction will default to the target's current position.
    var predicted_target_position := current_target.global_position + average_velocity * _calculate_intersection_time(ball.global_position)
    var delta: Vector3 = (predicted_target_position + Vector3.UP) - ball.global_position

    # A launch angle of 0 degrees will go straight ahead, which is fine for closer targets.
    var launch_angle := _calculate_launch_angle(PROJECTILE_SPEED, gravity, Vector2(delta.x, delta.z).length(), delta.y)
    if launch_angle > deg_to_rad(60):
        launch_angle = 0.0

    var sx := PROJECTILE_SPEED * cos(launch_angle)
    var sy := PROJECTILE_SPEED * sin(launch_angle)

    var horizontal_delta := predicted_target_position - ball.global_position
    horizontal_delta.y = 0

    var launch_force := horizontal_delta.normalized() * sx + Vector3.UP * sy

    ball.linear_velocity = Vector3.ZERO
    ball.apply_impulse(launch_force)


func _calculate_intersection_time(origin: Vector3) -> float:
    # Quadratic formula business.
    var a := average_velocity.dot(average_velocity) - PROJECTILE_SPEED * PROJECTILE_SPEED
    var b := 2 * (current_target.global_position - origin).dot(average_velocity)
    var c := (current_target.global_position - origin).length_squared()

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

