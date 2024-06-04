class_name FinetineButtons
extends VBoxContainer


@export_group("Vertical")
@export var up_button: Button
@export var down_button: Button
@export var vertical_step: float
var vertical_range: Vector2
var vertical_current: int

@export_group("Horizontal")
@export var left_button: Button
@export var right_button: Button
@export var horizontal_step: float
var horizontal_range: Vector2
var horizontal_current: int

@export_group("Rotation")
@export var rotate_left_button: Button
@export var rotate_right_button: Button
@export var rotation_step: float
var rotation_range: Vector2
var rotation_current: int

@export_group("Scaling")
@export var scale_up_button: Button
@export var scale_down_button: Button
@export var scaling_step: float
var scale_range: Vector2
var scale_current: int


func set_values(ranges: FinetuneRanges):
    vertical_range = ranges.vertical_min_max
    horizontal_range = ranges.horizontal_min_max
    rotation_range = ranges.rotation_min_max
    scale_range = ranges.scale_min_max
    
    if left_button != null:
        left_button.pressed.connect(_left)
    if right_button != null:
        right_button.pressed.connect(_right)
    
    if rotate_left_button != null:
        rotate_left_button.pressed.connect(_rotate_left)
    if rotate_right_button != null:
        rotate_right_button.pressed.connect(_rotate_right)
    
    up_button.pressed.connect(_up)
    down_button.pressed.connect(_down)

    scale_up_button.pressed.connect(_scale_up)
    scale_down_button.pressed.connect(_scale_down)


func get_values() -> FinetuneValues:
    var result = FinetuneValues.new()

    result.vertical = vertical_current
    result.horizontal = horizontal_current
    result.rotation = rotation_current
    result.scale = scale_current
    
    return result


func load_values(finetune_values: FinetuneValues):
    vertical_current = finetune_values.vertical
    horizontal_current = finetune_values.horizontal
    rotation_current = finetune_values.rotation
    scale_current = finetune_values.scale


func _up():
    vertical_current = min(vertical_range.y, vertical_current + vertical_step)
    
func _down():
    vertical_current = max(vertical_range.x, vertical_current - vertical_step)

func _left():
    horizontal_current = max(horizontal_range.x, horizontal_current - horizontal_step)

func _right():
    horizontal_current = min(horizontal_range.y, horizontal_current + horizontal_step)

func _rotate_left():
    rotation_current = max(rotation_range.x, rotation_current - rotation_step)

func _rotate_right():
    rotation_current = min(rotation_range.y, rotation_current + rotation_step)

func _scale_up():
    scale_current = min(scale_range.y, scale_current + scaling_step)

func _scale_down():
    scale_current = max(scale_range.x, scale_current - scaling_step)
