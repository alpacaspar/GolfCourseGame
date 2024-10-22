extends Node3D


const SENSITIVITY = 0.3

@onready var input_provider: InputProvider = $InputProvider
@onready var camera_pivot: Marker3D = $CameraPivot
@onready var attack_timer: Timer = $AttackTimer

var unit: CharacterBody3D


func _ready():
    input_provider.on_look.connect(_on_look)
    input_provider.on_interact_pressed.connect(_on_interact_pressed)
    input_provider.on_cancel_pressed.connect(_on_cancel_pressed)
    input_provider.on_cancel_released.connect(_on_cancel_released)
    attack_timer.wait_time = unit.role.attack_speed

    BattleManager.on_battle_started.connect(_on_battle_manager_battle_started)


func _physics_process(delta: float):
    unit.velocity.y = -1 if unit.is_on_floor() else unit.velocity.y - unit.gravity * delta

    var direction := (global_basis * Vector3(-input_provider.move.x, 0, -input_provider.move.y)).normalized()

    unit.velocity.x = direction.x * unit.move_speed
    unit.velocity.z = direction.z * unit.move_speed

    unit.move_and_slide()

    if not unit.is_attacking:
        var angle := atan2(global_basis.z.x, global_basis.z.z)
        unit.character_container.global_rotation.y = lerp_angle(unit.character_container.global_rotation.y, angle, 10 * delta)


func _on_look(input_delta: Vector2):
    if process_mode == PROCESS_MODE_DISABLED:
        return

    rotate_y(deg_to_rad(-input_delta.x) * SENSITIVITY) 

    camera_pivot.rotation.x = deg_to_rad(clamp(rad_to_deg(camera_pivot.rotation.x) - input_delta.y * SENSITIVITY, -70, 30))


func _on_interact_pressed():
    if unit.is_attacking:
        return
    
    if unit.is_blocking:
        unit.cancel_block()

    unit.is_attacking = true
    unit.perform_attack()
    attack_timer.start()


func _on_cancel_pressed():
    if unit.is_attacking:
        return
    
    unit.perform_block()


func _on_cancel_released():
    if unit.is_attacking:
        return
    
    unit.cancel_block()


func _on_exit():
    input_provider.on_look.disconnect(_on_look)


func _on_battle_manager_battle_started(_teams: Array[Team], _battle: Battle):
    input_provider._on_enter()


func _on_attack_timer_timeout() -> void:
    unit.is_attacking = false
