extends Node3D


const SENSITIVITY = 0.3

@onready var input_provider: InputProvider = $InputProvider
@onready var camera_pivot: Marker3D = $CameraPivot

var unit: CharacterBody3D

var current_speed := 0.0


func _ready():
    input_provider.on_look.connect(_on_look)
    input_provider.on_interact.connect(_on_interact)

    current_speed = unit.MOVE_SPEED

    BattleManager.on_battle_started.connect(_on_battle_manager_battle_started)


func _physics_process(delta: float):
    unit.velocity.y = -1 if unit.is_on_floor() else unit.velocity.y - unit.gravity * delta

    var direction := (unit.transform.basis * Vector3(-input_provider.move.x, 0, -input_provider.move.y)).normalized()

    unit.velocity.x = direction.x * current_speed
    unit.velocity.z = direction.z * current_speed

    # This function already uses the delta time internally.
    unit.move_and_slide()


func _on_look(input_delta: Vector2):
    if process_mode == PROCESS_MODE_DISABLED:
        return

    unit.rotate_y(deg_to_rad(-input_delta.x) * SENSITIVITY) 
    camera_pivot.rotate_x(deg_to_rad(input_delta.y) * SENSITIVITY)

    camera_pivot.rotation_degrees.x = clamp(camera_pivot.rotation_degrees.x, -70, 30)


func _on_interact():
    if unit.state == unit.ATTACKING:
        return

    _perform_action()


func _on_exit():
    input_provider.on_look.disconnect(_on_look)


func _on_battle_manager_battle_started():
    input_provider._on_enter()


func _perform_action():
    unit.state = unit.ATTACKING
    current_speed = 4.0

    unit.perform_action()

    # TODO: Use perform_action() function to get the duration.
    await get_tree().create_timer(3).timeout

    current_speed = unit.MOVE_SPEED
    unit.state = unit.IDLE
